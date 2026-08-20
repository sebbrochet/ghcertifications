# build-pandoc.ps1
# Builds the EPUB (and PDF if xelatex is present) of the "Copilot to Agents" ebook
# from the Markdown chapters in chapters/.
#
# This script runs in CI (.github/workflows/build-and-deploy.yml) on a GitHub-hosted runner,
# where Pandoc, Node/mermaid-cli and a LaTeX engine are installed automatically. You can also
# run it locally on any machine where Pandoc is allowed. The project is portable (paths are
# relative to build/).
#
# Prerequisites (only if running locally):
#   winget install JohnMacFarlane.Pandoc            # Pandoc (EPUB + PDF)
#   npm install -g @mermaid-js/mermaid-cli          # mmdc (renders Mermaid diagrams to PNG)
#   winget install MiKTeX.MiKTeX                     # xelatex (PDF only, optional)
#
# Usage (from the project root):
#   .\build\build-pandoc.ps1            # EPUB (+ PDF if xelatex available)
#   .\build\build-pandoc.ps1 -EpubOnly
#   .\build\build-pandoc.ps1 -PdfOnly

param(
    [switch]$PdfOnly,
    [switch]$EpubOnly
)

$buildDir    = $PSScriptRoot
$projectRoot = Split-Path $PSScriptRoot -Parent
$chapDir     = Join-Path $projectRoot 'chapters'
$output      = Join-Path $projectRoot 'output'
$assetsDir   = Join-Path $projectRoot 'assets'

if (-not (Test-Path $output)) { New-Item -ItemType Directory -Path $output -Force | Out-Null }

Write-Host "=== Pandoc builder — Copilot to Agents ===" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Pandoc not found. Install it: winget install JohnMacFarlane.Pandoc" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Pandoc: $(pandoc --version | Select-Object -First 1)" -ForegroundColor Green

# --- Ordered list of chapters (excludes the template `_*.md` and the web-only downloads page) ---
$bookFiles = Get-ChildItem $chapDir -Filter '*.md' |
    Where-Object { $_.Name -notmatch '^_' -and $_.Name -ne 'downloads.md' } |
    Sort-Object { if ($_.Name -eq 'index.md') { '000-index.md' } else { $_.Name } } |
    ForEach-Object { $_.FullName }

if (-not $bookFiles) {
    Write-Host "[ERROR] No chapters found in $chapDir" -ForegroundColor Red
    exit 1
}
Write-Host "[OK] $($bookFiles.Count) chapters found" -ForegroundColor Green

# --- Metadata ---
$title    = "Copilot to Agents"
$subtitle = "The complete guide to GitHub's AI developer certifications — GH-300 & GH-600"
$author   = "Sébastien Brochet"
$date     = (Get-Date).ToString("MMMM yyyy", [System.Globalization.CultureInfo]::GetCultureInfo("en-US"))
$lang     = "en"

$commonArgs = @(
    "--from=markdown+pipe_tables+backtick_code_blocks+fenced_code_blocks+tex_math_dollars"
    "--toc"
    "--toc-depth=1"
    "--metadata=title:$title"
    "--metadata=subtitle:$subtitle"
    "--metadata=author:$author"
    "--metadata=date:$date"
    "--metadata=lang:$lang"
    "--file-scope"
)

# ============================================================
# Strip emoji for the PDF (xelatex does not render them).
# We also remove the space following an emoji so bold spans
# like "**📌 Key concept ...**" are not broken.
# ============================================================
function Remove-Emoji {
    param([string]$Content)
    $emojis = @('📌', '🔍', '🎯', '⚠️', '⚠', '💡', '📖', '🔗', '🖥️', '🖥', '🗣️', '🗣', '🔬', '✅', '📊', '📆', '🚧', '🧭', '🔥', '🧠', '⏱️', '⏱', '🤖')
    foreach ($e in $emojis) {
        $Content = $Content.Replace("$e ", '').Replace($e, '')
    }
    $Content = $Content.Replace('➡️', '→').Replace('➡', '→')
    $Content = $Content.Replace([string][char]0xFE0F, '')            # variation selector
    $Content = [regex]::Replace($Content, '[\uD800-\uDBFF][\uDC00-\uDFFF]', '')  # safety net
    return $Content
}

# ============================================================
# Working manuscripts (EPUB: emoji kept; PDF: emoji stripped)
# ============================================================
$epubManuscript = Join-Path $output 'epub-manuscript'
$pdfManuscript  = Join-Path $output 'pdf-manuscript'
foreach ($d in @($epubManuscript, $pdfManuscript)) {
    if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

Write-Host "  Preparing working manuscripts..." -ForegroundColor Gray
foreach ($file in $bookFiles) {
    $raw  = Get-Content $file -Raw -Encoding UTF8
    $leaf = Split-Path $file -Leaf
    Set-Content -Path (Join-Path $epubManuscript $leaf) -Value $raw -Encoding UTF8 -NoNewline
    Set-Content -Path (Join-Path $pdfManuscript  $leaf) -Value (Remove-Emoji $raw) -Encoding UTF8 -NoNewline
}

# ============================================================
# Render Mermaid diagrams to PNG (content-hash cache + parallel)
# ============================================================
$diagramCache = Join-Path $output 'diagram-cache'
if (-not (Test-Path $diagramCache)) { New-Item -ItemType Directory -Path $diagramCache -Force | Out-Null }
foreach ($d in @((Join-Path $epubManuscript 'diagrams'), (Join-Path $pdfManuscript 'diagrams'))) {
    if (-not (Test-Path $d)) { New-Item -ItemType Directory -Path $d -Force | Out-Null }
}

$mermaidPattern = '(?ms)```mermaid\r?\n(.*?)```'
function Get-DiagHash {
    param([string]$Code)
    [System.BitConverter]::ToString(
        [System.Security.Cryptography.SHA256]::Create().ComputeHash(
            [System.Text.Encoding]::UTF8.GetBytes($Code))).Replace('-', '').Substring(0, 12)
}

$mmdc = Get-Command mmdc -ErrorAction SilentlyContinue
$mermaidConfig = Join-Path $buildDir 'mermaid-config.json'

if ($mmdc) {
    Write-Host "  Rendering Mermaid diagrams..." -ForegroundColor Gray
    $toRender = @()
    $total = 0
    foreach ($mdFile in (Get-ChildItem $epubManuscript -Filter '*.md')) {
        $content = Get-Content $mdFile.FullName -Raw -Encoding UTF8
        $blocks  = [regex]::Matches($content, $mermaidPattern)
        if ($blocks.Count -eq 0) { continue }
        $base = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name)
        $i = 0
        foreach ($b in $blocks) {
            $i++
            $hash = Get-DiagHash $b.Groups[1].Value
            $png  = Join-Path $diagramCache "$base-diagram-$i-$hash.png"
            if (-not (Test-Path $png)) {
                $mmd = Join-Path $diagramCache "$base-diagram-$i.mmd"
                Set-Content -Path $mmd -Value $b.Groups[1].Value -Encoding UTF8 -NoNewline
                $toRender += @{ Mmd = $mmd; Png = $png }
            }
            $total++
        }
    }
    if ($toRender.Count -gt 0) {
        Write-Host "    $($toRender.Count) new diagram(s) ($($total - $toRender.Count) cached)..." -ForegroundColor Gray
        $cfg = if (Test-Path $mermaidConfig) { $mermaidConfig } else { $null }
        # Optional puppeteer config (e.g. --no-sandbox for headless Chromium on CI runners).
        $puppeteerConfig = Join-Path $buildDir 'puppeteer-config.json'
        $puppeteer = if (Test-Path $puppeteerConfig) { $puppeteerConfig } else { $null }
        $mmdcSource = $mmdc.Source
        $toRender | ForEach-Object -ThrottleLimit 4 -Parallel {
            $item = $_
            try {
                $a = @('-i', $item.Mmd, '-o', $item.Png, '-b', 'white', '-w', '900', '-s', '2')
                if ($using:cfg) { $a += @('-c', $using:cfg) }
                if ($using:puppeteer) { $a += @('-p', $using:puppeteer) }
                & $using:mmdcSource @a 2>&1 | Out-Null
            } catch {
                Write-Warning "Mermaid render failed: $($item.Mmd)"
            }
        }
    }
    # Replace mermaid blocks with images in both manuscripts
    foreach ($manu in @($epubManuscript, $pdfManuscript)) {
        $diagOut = Join-Path $manu 'diagrams'
        foreach ($mdFile in (Get-ChildItem $manu -Filter '*.md')) {
            $content = Get-Content $mdFile.FullName -Raw -Encoding UTF8
            $blocks  = [regex]::Matches($content, $mermaidPattern)
            if ($blocks.Count -eq 0) { continue }
            $base = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name)
            $i = 0
            foreach ($b in $blocks) {
                $i++
                $hash = Get-DiagHash $b.Groups[1].Value
                $png  = Join-Path $diagramCache "$base-diagram-$i-$hash.png"
                if (Test-Path $png) {
                    Copy-Item $png (Join-Path $diagOut "$base-diagram-$i.png") -Force
                    $content = $content.Replace($b.Value, "![Diagram](diagrams/$base-diagram-$i.png)")
                } else {
                    Write-Host "    [WARN] Diagram not rendered: $base-diagram-$i" -ForegroundColor Yellow
                }
            }
            Set-Content -Path $mdFile.FullName -Value $content -Encoding UTF8 -NoNewline
        }
    }
    Write-Host "  [OK] $total diagram(s) processed" -ForegroundColor Green
} else {
    Write-Host "  [SKIP] mmdc not found — diagrams will stay as code blocks." -ForegroundColor Yellow
    Write-Host "         Install it: npm install -g @mermaid-js/mermaid-cli" -ForegroundColor Yellow
}

$epubBookFiles = $bookFiles | ForEach-Object { Join-Path $epubManuscript (Split-Path $_ -Leaf) }
$pdfBookFiles  = $bookFiles | ForEach-Object { Join-Path $pdfManuscript  (Split-Path $_ -Leaf) }

# ============================================================
# EPUB
# ============================================================
if (-not $PdfOnly) {
    Write-Host ""
    Write-Host "--- Building EPUB ---" -ForegroundColor Yellow
    $epubOut = Join-Path $output 'Copilot-to-Agents.epub'
    $epubArgs = @('-o', $epubOut, '--split-level=1', "--resource-path=$epubManuscript")
    $cover = Join-Path $assetsDir 'cover.png'
    if (Test-Path $cover) {
        $epubArgs += "--epub-cover-image=$cover"
        Write-Host "  [OK] Cover included" -ForegroundColor Green
    }
    $epubArgs += $commonArgs + $epubBookFiles
    & pandoc @epubArgs 2>&1 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
    if (Test-Path $epubOut) {
        $sz = [math]::Round((Get-Item $epubOut).Length / 1MB, 2)
        Write-Host "  [OK] EPUB built: $epubOut ($sz MB)" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] EPUB build" -ForegroundColor Red
    }
}

# ============================================================
# PDF (if xelatex present)
# ============================================================
if (-not $EpubOnly) {
    Write-Host ""
    Write-Host "--- Building PDF ---" -ForegroundColor Yellow
    if (-not (Get-Command xelatex -ErrorAction SilentlyContinue)) {
        Write-Host "  [SKIP] xelatex not found. Install MiKTeX: winget install MiKTeX.MiKTeX" -ForegroundColor Yellow
    } else {
        $pdfOut = Join-Path $output 'Copilot-to-Agents.pdf'
        $header = Join-Path $buildDir 'latex-header.tex'
        # Fonts are overridable for CI/Linux (Segoe UI / Consolas are Windows-only).
        # Set PANDOC_MAINFONT / PANDOC_MONOFONT to fonts installed on the runner (e.g. DejaVu).
        $mainFont = if ($env:PANDOC_MAINFONT) { $env:PANDOC_MAINFONT } else { 'Segoe UI' }
        $monoFont = if ($env:PANDOC_MONOFONT) { $env:PANDOC_MONOFONT } else { 'Consolas' }
        $pdfArgs = @(
            '-o', $pdfOut
            '--pdf-engine=xelatex'
            '-V', 'geometry:margin=2cm'
            '-V', 'fontsize=11pt'
            '-V', 'documentclass=book'
            '-V', 'classoption=oneside'
            '-V', "mainfont:$mainFont"
            '-V', "monofont:$monoFont"
            '-V', 'linkcolor:NavyBlue'
            '-V', 'urlcolor:NavyBlue'
            "--include-in-header=$header"
            "--resource-path=$pdfManuscript"
        ) + $commonArgs + $pdfBookFiles
        Write-Host "  Running pandoc (PDF, may take a minute)..." -ForegroundColor Gray
        & pandoc @pdfArgs 2>&1 | ForEach-Object {
            $l = "$_"
            if ($l -match 'not checked for MiKTeX updates') { return }
            Write-Host "  $l" -ForegroundColor Gray
        }
        if (Test-Path $pdfOut) {
            $sz = [math]::Round((Get-Item $pdfOut).Length / 1MB, 2)
            Write-Host "  [OK] PDF built: $pdfOut ($sz MB)" -ForegroundColor Green
        } else {
            Write-Host "  [FAIL] PDF build (see LaTeX errors above)" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Cyan
Get-ChildItem -Path $output -File | ForEach-Object {
    $sz = [math]::Round($_.Length / 1MB, 2)
    Write-Host "  $($_.Name)  ($sz MB)" -ForegroundColor Green
}
