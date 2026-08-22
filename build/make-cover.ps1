# make-cover.ps1
# Generates chapters/assets/cover.png (1600 x 2560 px, KDP ratio 1.6) WITHOUT a browser,
# directly via System.Drawing (GDI+). Deterministic and portable.
#
# Palette "GitHub / Copilot": near-black background + blue + purple accents + gold,
# aligned with the MkDocs theme (black/indigo) and mermaid-config.json.
#
# Usage:  .\build\make-cover.ps1

Add-Type -AssemblyName System.Drawing

$projectRoot = Split-Path $PSScriptRoot -Parent
$assetsDir   = Join-Path $projectRoot 'chapters\assets'
if (-not (Test-Path $assetsDir)) { New-Item -ItemType Directory -Path $assetsDir -Force | Out-Null }
$out = Join-Path $assetsDir 'cover.png'

$W = 1600; $H = 2560
function C([string]$hex) { [System.Drawing.ColorTranslator]::FromHtml($hex) }
function A([int]$a, $col) { [System.Drawing.Color]::FromArgb($a, $col.R, $col.G, $col.B) }

$gold   = C '#f5c85a'
$blue   = C '#58a6ff'
$purple = C '#a371f7'
$white  = C '#ffffff'
$light  = C '#d0d7de'
$soft   = C '#adbac7'
$muted  = C '#768390'

$bmp = New-Object System.Drawing.Bitmap $W, $H
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# --- Background: 3-stop vertical gradient (GitHub dark) ---
$rect = New-Object System.Drawing.Rectangle 0, 0, $W, $H
$lgb  = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, (C '#161b22'), (C '#010409'), [System.Drawing.Drawing2D.LinearGradientMode]::Vertical)
$blend = New-Object System.Drawing.Drawing2D.ColorBlend 3
$blend.Colors    = @((C '#1b2230'), (C '#131a26'), (C '#010409'))
$blend.Positions = @(0.0, 0.42, 1.0)
$lgb.InterpolationColors = $blend
$g.FillRectangle($lgb, $rect)

# --- Bright halo at the top (purple/blue) ---
$gp = New-Object System.Drawing.Drawing2D.GraphicsPath
$gp.AddEllipse(150, -560, 1300, 1300)
$pgb = New-Object System.Drawing.Drawing2D.PathGradientBrush($gp)
$pgb.CenterColor = (A 80 (C '#a371f7'))
$pgb.SurroundColors = @((A 0 (C '#a371f7')))
$g.FillPath($pgb, $gp)

# --- Gold frame ---
$penFrame = New-Object System.Drawing.Pen((A 150 $gold), 2)
$g.DrawRectangle($penFrame, 72, 72, ($W - 144), ($H - 144))

# --- Fonts (pixel unit) ---
$UPix = [System.Drawing.GraphicsUnit]::Pixel
function Font([single]$size, [System.Drawing.FontStyle]$style) { New-Object System.Drawing.Font('Segoe UI', $size, $style, $UPix) }
$bold    = [System.Drawing.FontStyle]::Bold
$reg     = [System.Drawing.FontStyle]::Regular
$semi    = [System.Drawing.FontStyle]::Bold

$mLeft = 200

# Text brushes
$brGold   = New-Object System.Drawing.SolidBrush $gold
$brBlue   = New-Object System.Drawing.SolidBrush $blue
$brPurple = New-Object System.Drawing.SolidBrush $purple
$brWhite  = New-Object System.Drawing.SolidBrush $white
$brLight  = New-Object System.Drawing.SolidBrush $light
$brSoft   = New-Object System.Drawing.SolidBrush $soft
$brMuted  = New-Object System.Drawing.SolidBrush $muted

# Helper: text with simulated letter-spacing (tracking)
function Draw-Tracked($text, $font, $brush, [single]$x, [single]$y, [single]$tracking) {
    $cx = $x
    foreach ($ch in $text.ToCharArray()) {
        $s = [string]$ch
        $g.DrawString($s, $font, $brush, $cx, $y)
        $w = $g.MeasureString($s, $font).Width
        $cx += $w - $font.Size * 0.30 + $tracking
    }
}

# --- Overline ---
$fOver = Font 30 $semi
Draw-Tracked "GITHUB CERTIFICATIONS   •   2026 EDITION" $fOver $brGold $mLeft 250 6

# --- Title (two lines) ---
$fT1 = Font 200 $bold
$g.DrawString("COPILOT", $fT1, $brWhite, ($mLeft - 12), 460)
$fT2 = Font 150 $bold
$g.DrawString("TO AGENTS", $fT2, $brBlue, ($mLeft - 6), 700)

# --- Gold rule ---
$g.FillRectangle($brGold, $mLeft, 900, 240, 9)

# --- Subtitle (wrapped) ---
$fSub = Font 47 $reg
$sfSub = New-Object System.Drawing.StringFormat
$subRect = New-Object System.Drawing.RectangleF $mLeft, 970, 1080, 320
$subtitle = "The complete guide to GitHub's AI developer certifications: from Copilot user to agent engineer — GH-300 & GH-600."
$g.DrawString($subtitle, $fSub, $brLight, $subRect, $sfSub)

# --- Exam / domain lines ---
$fDom = Font 32 $semi
Draw-Tracked "EXAM GH-300  /  EXAM GH-600" $fDom $brMuted $mLeft 1440 4
Draw-Tracked "COPILOT  /  MCP  /  AGENTS  /  GUARDRAILS" $fDom $brMuted $mLeft 1500 4

# --- Network motif (agents as connected nodes) ---
$nodes = @(
    @(200,1980), @(470,1780), @(760,1900), @(1050,1720),
    @(1200,1980), @(1400,1800), @(560,2060), @(940,2050), @(1330,2040)
)
$edges = @(
    @(0,1),@(1,2),@(2,3),@(3,4),@(4,5),@(0,6),@(6,2),@(2,7),@(7,4),@(3,8),@(8,5)
)
$penNet = New-Object System.Drawing.Pen((A 90 $purple), 2.5)
foreach ($e in $edges) {
    $a = $nodes[$e[0]]; $b = $nodes[$e[1]]
    $g.DrawLine($penNet, [single]$a[0], [single]$a[1], [single]$b[0], [single]$b[1])
}
$radii = @(10,14,10,17,12,11,9,11,9)
for ($i = 0; $i -lt $nodes.Count; $i++) {
    $n = $nodes[$i]; $r = $radii[$i]
    $g.FillEllipse($brBlue, [single]($n[0]-$r), [single]($n[1]-$r), [single]($r*2), [single]($r*2))
}
# Two gold nodes (accents)
$g.FillEllipse($brGold, 754, 1894, 12, 12)
$g.FillEllipse($brGold, 1044, 1714, 12, 12)

# --- Footer: author + edition note ---
$fBy = Font 30 $semi
Draw-Tracked "BY" $fBy $brMuted $mLeft 2330 5
$fAuthor = Font 58 $bold
$g.DrawString("Sébastien Brochet", $fAuthor, $brWhite, ($mLeft - 4), 2372)

$fEd = Font 34 $semi
$sfR = New-Object System.Drawing.StringFormat
$sfR.Alignment = [System.Drawing.StringAlignment]::Far
$edRect = New-Object System.Drawing.RectangleF 800, 2372, 600, 120
$g.DrawString("16 chapters`n+ mock exams", $fEd, $brGold, $edRect, $sfR)

# --- Save ---
if (Test-Path $out) { Remove-Item $out -Force }
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()

$sz = [math]::Round((Get-Item $out).Length / 1KB, 0)
Write-Host "[OK] Cover generated: chapters/assets/cover.png ($W x $H px, $sz KB)" -ForegroundColor Green
Write-Host "     Served by MkDocs (web) and embedded in the EPUB/PDF by build-pandoc.ps1." -ForegroundColor Gray
