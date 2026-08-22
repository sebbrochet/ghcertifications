# build-local.ps1
# One-command LOCAL generation of the EPUB + PDF into the top-level output/ folder,
# for previewing/testing the two downloadable formats before pushing.
#
# In CI the EPUB/PDF are built by .github/workflows/build-and-deploy.yml; this script is
# a convenience wrapper for local runs (it chains the cover generator and the Pandoc build).
#
# Prerequisites (local):
#   winget install JohnMacFarlane.Pandoc            # Pandoc (EPUB + PDF)
#   npm install -g @mermaid-js/mermaid-cli          # mmdc (renders Mermaid diagrams)
#   winget install MiKTeX.MiKTeX                     # xelatex (PDF)
#
# Usage (from the project root):
#   .\build\build-local.ps1                 # EPUB + PDF -> output/ (reuses the existing cover)
#   .\build\build-local.ps1 -Open           # ...and open both files afterwards
#   .\build\build-local.ps1 -RegenerateCover  # rebuild the basic GDI+ cover first (opt-in)
#   .\build\build-local.ps1 -EpubOnly       # EPUB only
#   .\build\build-local.ps1 -PdfOnly        # PDF only
#   .\build\build-local.ps1 -NoDiagrams     # skip Mermaid rendering (fast text-only preview)

param(
    [switch]$RegenerateCover,
    [switch]$Open,
    [switch]$EpubOnly,
    [switch]$PdfOnly,
    [switch]$NoDiagrams
)

$ErrorActionPreference = 'Stop'
$buildDir    = $PSScriptRoot
$projectRoot = Split-Path $PSScriptRoot -Parent
$output      = Join-Path $projectRoot 'output'

# --- 1. Cover ---
# By default we REUSE the existing cover (chapters/assets/cover.png) — it may be a higher-quality
# one produced by an external tool. The basic GDI+ generator ONLY runs if you pass -RegenerateCover.
# If no cover exists at all, we warn and continue (the EPUB/PDF simply omit the cover) rather than
# silently overwriting with a placeholder.
$coverPath = Join-Path $projectRoot 'chapters\assets\cover.png'
if ($RegenerateCover) {
    Write-Host "=== Regenerating cover (basic GDI+) ===" -ForegroundColor Cyan
    & (Join-Path $buildDir 'make-cover.ps1')
    Write-Host ""
} elseif (Test-Path $coverPath) {
    Write-Host "=== Reusing existing cover: chapters/assets/cover.png (not regenerated) ===" -ForegroundColor Cyan
} else {
    Write-Host "=== No cover found at chapters/assets/cover.png — building without a cover ===" -ForegroundColor Yellow
    Write-Host "    (run with -RegenerateCover to create a basic placeholder)" -ForegroundColor Yellow
}
# Refresh the web thumbnail (cover-web.jpg) and social image (og-cover.jpg) from the current master.
if (Test-Path $coverPath) { & (Join-Path $buildDir 'make-web-images.ps1'); Write-Host "" }
Write-Host ""

# --- 2. EPUB + PDF via Pandoc (writes to output/) ---
$pandocArgs = @{}
if ($EpubOnly)   { $pandocArgs['EpubOnly']   = $true }
if ($PdfOnly)    { $pandocArgs['PdfOnly']    = $true }
if ($NoDiagrams) { $pandocArgs['NoDiagrams'] = $true }
& (Join-Path $buildDir 'build-pandoc.ps1') @pandocArgs

# --- 3. Report the deliverables in output/ ---
Write-Host ""
Write-Host "=== Local build complete — output/ ===" -ForegroundColor Cyan
$epub = Join-Path $output 'Copilot-to-Agents.epub'
$pdf  = Join-Path $output 'Copilot-to-Agents.pdf'
$deliverables = @()
if (-not $PdfOnly)  { $deliverables += $epub }
if (-not $EpubOnly) { $deliverables += $pdf }
foreach ($f in $deliverables) {
    if (Test-Path $f) {
        $sz = [math]::Round((Get-Item $f).Length / 1MB, 2)
        Write-Host ("  [OK] {0} ({1} MB)" -f (Resolve-Path $f), $sz) -ForegroundColor Green
    } else {
        Write-Host ("  [MISSING] {0}" -f $f) -ForegroundColor Yellow
    }
}

if ($Open) {
    foreach ($f in $deliverables) { if (Test-Path $f) { Start-Process $f } }
}
