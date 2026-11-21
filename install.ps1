# Installs the Shadow System theme (JSON + background PNG) into T3 Code's themes folder.
# Checks both files first, backs up any different existing copy with a timestamp, never deletes anything.
$ErrorActionPreference = 'Stop'
$base = if ($env:T3CODE_HOME) { $env:T3CODE_HOME } else { Join-Path $env:USERPROFILE '.t3' }
$dest = Join-Path $base 'userdata\themes'
$files = 'shadow-system.json', 'shadow-system.png'

foreach ($f in $files) {
    $src = Join-Path $PSScriptRoot "theme\$f"
    if (-not (Test-Path $src)) { throw "Missing $src" }
}

New-Item -ItemType Directory -Force -Path $dest | Out-Null
Write-Host "Themes folder: $dest"
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'

# stage both files first, so a failure can't leave a mismatched pair
foreach ($f in $files) { Copy-Item (Join-Path $PSScriptRoot "theme\$f") (Join-Path $dest ".$f.new") -Force }
foreach ($f in $files) {
    $target = Join-Path $dest $f
    $staged = Join-Path $dest ".$f.new"
    if ((Test-Path $target) -and ((Get-FileHash $staged).Hash -ne (Get-FileHash $target).Hash)) {
        Copy-Item $target "$target.bak-$stamp"
        Write-Host "Existing $f differed; saved as $f.bak-$stamp"
    }
}
foreach ($f in $files) { Move-Item (Join-Path $dest ".$f.new") (Join-Path $dest $f) -Force; Write-Host "Installed $f" }

Write-Host "Done. In T3 Code open Settings > Appearance > Themes and pick 'Shadow Monarch: System' (dark mode)."
Write-Host "Don't import it with 'Add theme': themes imported there don't get their background image."
