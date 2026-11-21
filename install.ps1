# Installs the Shadow System theme into T3 Code's themes folder. Never deletes anything.
$ErrorActionPreference = 'Stop'
$base = if ($env:T3CODE_HOME) { $env:T3CODE_HOME } else { Join-Path $env:USERPROFILE '.t3' }
$dest = Join-Path $base 'userdata\themes'

New-Item -ItemType Directory -Force -Path $dest | Out-Null
Write-Host "Themes folder: $dest"
foreach ($f in 'shadow-system.json', 'shadow-system.png') {
    $src = Join-Path $PSScriptRoot "theme\$f"
    if (-not (Test-Path $src)) { throw "Missing $src" }
    $target = Join-Path $dest $f
    if ((Test-Path $target) -and ((Get-FileHash $src).Hash -ne (Get-FileHash $target).Hash)) {
        Copy-Item $target "$target.bak" -Force
        Write-Host "Existing $f differed; saved as $f.bak"
    }
    Copy-Item $src $target -Force
    Write-Host "Copied $f"
}
Write-Host "Done. In T3 Code open Settings > Appearance > Themes and pick 'Shadow Monarch: System'."
