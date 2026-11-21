# Installs the Shadow System theme (JSON + background PNG) into T3 Code's themes folder.
# Checks both files first and backs up any different existing copy with a timestamp.
& {
    $ErrorActionPreference = 'Stop'
    $base = if ($env:T3CODE_HOME) { $env:T3CODE_HOME } else { Join-Path $env:USERPROFILE '.t3' }
    $dest = Join-Path $base 'userdata\themes'
    $files = 'shadow-system.json', 'shadow-system.png'
    $source = if ($PSScriptRoot) { Join-Path $PSScriptRoot 'theme' }
    $missing = $files | Where-Object {
        -not $source -or -not (Test-Path -LiteralPath (Join-Path $source $_) -PathType Leaf)
    }
    $download = $null

    try {
        if ($missing) {
            $download = New-Item -ItemType Directory -Path (Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString()))
            $source = $download.FullName
            $remote = 'https://raw.githubusercontent.com/ArcticSlayy/shadow-system-t3-theme/main/theme'
            foreach ($f in $files) {
                Invoke-WebRequest -UseBasicParsing -Uri "$remote/$f" -OutFile (Join-Path $source $f)
            }
        }

        foreach ($f in $files) {
            $src = Join-Path $source $f
            if (-not (Test-Path -LiteralPath $src -PathType Leaf)) { throw "Missing $src" }
        }

        New-Item -ItemType Directory -Force -Path $dest | Out-Null
        Write-Host "Themes folder: $dest"
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'

        # Stage both files before replacing either installed file.
        foreach ($f in $files) { Copy-Item (Join-Path $source $f) (Join-Path $dest ".$f.new") -Force }
        foreach ($f in $files) {
            $target = Join-Path $dest $f
            $staged = Join-Path $dest ".$f.new"
            if ((Test-Path $target) -and ((Get-FileHash -LiteralPath $staged).Hash -ne
                    (Get-FileHash -LiteralPath $target).Hash)) {
                Copy-Item $target "$target.bak-$stamp"
                Write-Host "Existing $f differed; saved as $f.bak-$stamp"
            }
        }
        foreach ($f in $files) { Move-Item (Join-Path $dest ".$f.new") (Join-Path $dest $f) -Force; Write-Host "Installed $f" }

        Write-Host "Done. In T3 Code open Settings > Appearance > Themes and pick 'Shadow Monarch: System' (dark mode)."
        Write-Host "Don't import it with 'Add theme': themes imported there don't get their background image."
    } finally {
        if ($download) {
            foreach ($f in $files) {
                $file = Join-Path $download.FullName $f
                if (Test-Path -LiteralPath $file -PathType Leaf) { Remove-Item -LiteralPath $file }
            }
            Remove-Item -LiteralPath $download.FullName
        }
    }
}
