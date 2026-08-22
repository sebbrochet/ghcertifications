# make-web-images.ps1
# Derives lightweight web images from the high-res master cover (chapters/assets/cover.png):
#   - cover-web.jpg : ~600 px-wide thumbnail for the Introduction page (web only)
#   - og-cover.jpg  : 1200 x 630 social/Open Graph card (full cover + title on a branded background)
#
# Downscale / compose ONLY — the master cover.png is never modified. Run this whenever the master
# cover changes; the derivatives are committed and served as-is by MkDocs (no image tooling in CI).
#
# Usage:  .\build\make-web-images.ps1

Add-Type -AssemblyName System.Drawing

$projectRoot = Split-Path $PSScriptRoot -Parent
$assets = Join-Path $projectRoot 'chapters\assets'
$src    = Join-Path $assets 'cover.png'
if (-not (Test-Path $src)) {
    Write-Host "[ERROR] Master cover not found: $src" -ForegroundColor Red
    exit 1
}

$master = [System.Drawing.Image]::FromFile((Resolve-Path $src).Path)

function New-HighQualityGraphics($bmp) {
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    return $g
}
$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
function Save-Jpeg($bmp, $path, [int]$quality = 82) {
    if (Test-Path $path) { Remove-Item $path -Force }
    $enc = New-Object System.Drawing.Imaging.EncoderParameters 1
    $enc.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]$quality)
    $bmp.Save($path, $jpegCodec, $enc)
}

# --- 1. Web thumbnail: 600 px wide, proportional height ---
$tw = 600
$th = [int][math]::Round($master.Height * ($tw / $master.Width))
$web = New-Object System.Drawing.Bitmap $tw, $th
$g = New-HighQualityGraphics $web
$g.DrawImage($master,
    (New-Object System.Drawing.Rectangle 0, 0, $tw, $th),
    (New-Object System.Drawing.Rectangle 0, 0, $master.Width, $master.Height),
    [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()
$webPath = Join-Path $assets 'cover-web.jpg'
Save-Jpeg $web $webPath 82
$web.Dispose()

# --- 2. OG / social image: 1200 x 630 composed card (full cover + title on a branded background) ---
# A crop of the tall cover truncates it; instead we place the WHOLE cover on a gradient
# background with the title beside it, which renders well as a social preview.
$ow = 1200; $oh = 630
$og = New-Object System.Drawing.Bitmap $ow, $oh
$g2 = New-HighQualityGraphics $og
$g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

# Background: vertical gradient matching the cover palette (GitHub dark)
$bgRect = New-Object System.Drawing.Rectangle 0, 0, $ow, $oh
$bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush($bgRect,
    [System.Drawing.ColorTranslator]::FromHtml('#161b22'),
    [System.Drawing.ColorTranslator]::FromHtml('#010409'),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical)
$g2.FillRectangle($bg, $bgRect)

# Full cover (contain) on the left, with a thin gold border
$cMargin = 55
$cH = $oh - 2 * $cMargin
$cW = [int][math]::Round($cH * ($master.Width / $master.Height))
$cX = 80; $cY = $cMargin
$g2.DrawImage($master,
    (New-Object System.Drawing.Rectangle $cX, $cY, $cW, $cH),
    (New-Object System.Drawing.Rectangle 0, 0, $master.Width, $master.Height),
    [System.Drawing.GraphicsUnit]::Pixel)
$goldPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml('#f5c85a'), 2)
$g2.DrawRectangle($goldPen, $cX, $cY, $cW, $cH)

# Text column on the right
$UPix    = [System.Drawing.GraphicsUnit]::Pixel
$tx      = $cX + $cW + 70
$twCol   = $ow - $tx - 70
$dot     = [char]0x00B7
$goldBr  = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml('#f5c85a'))
$blueBr  = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml('#58a6ff'))
$whiteBr = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
$lightBr = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml('#d0d7de'))

$fEyebrow = New-Object System.Drawing.Font('Segoe UI', 17, [System.Drawing.FontStyle]::Bold, $UPix)
$fTitle   = New-Object System.Drawing.Font('Segoe UI', 56, [System.Drawing.FontStyle]::Bold, $UPix)
$fSub     = New-Object System.Drawing.Font('Segoe UI', 23, [System.Drawing.FontStyle]::Regular, $UPix)
$fBadge   = New-Object System.Drawing.Font('Segoe UI', 29, [System.Drawing.FontStyle]::Bold, $UPix)
$fAuthor  = New-Object System.Drawing.Font('Segoe UI', 21, [System.Drawing.FontStyle]::Regular, $UPix)

$g2.DrawString('GITHUB CERTIFICATION STUDY GUIDE', $fEyebrow, $blueBr, (New-Object System.Drawing.RectangleF $tx, 90, $twCol, 34))
$g2.DrawString('Copilot to Agents', $fTitle, $whiteBr, (New-Object System.Drawing.RectangleF $tx, 132, $twCol, 200))
$g2.DrawString("The complete guide to GitHub's AI developer certifications", $fSub, $lightBr, (New-Object System.Drawing.RectangleF $tx, 350, $twCol, 90))
$g2.DrawString("GH-300  $dot  GH-600", $fBadge, $goldBr, (New-Object System.Drawing.RectangleF $tx, 455, $twCol, 46))
$g2.DrawString(('S' + [char]0x00E9 + 'bastien Brochet'), $fAuthor, $lightBr, (New-Object System.Drawing.RectangleF $tx, 545, $twCol, 36))

$g2.Dispose()
$ogPath = Join-Path $assets 'og-cover.jpg'
Save-Jpeg $og $ogPath 85
$og.Dispose()

$master.Dispose()

Write-Host ("[OK] cover-web.jpg ({0} x {1}, {2} KB)" -f $tw, $th, [math]::Round((Get-Item $webPath).Length / 1KB)) -ForegroundColor Green
Write-Host ("[OK] og-cover.jpg ({0} x {1}, {2} KB)" -f $ow, $oh, [math]::Round((Get-Item $ogPath).Length / 1KB)) -ForegroundColor Green
