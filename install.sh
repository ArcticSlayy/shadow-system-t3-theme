#!/bin/sh
# Installs the Shadow System theme (JSON + background PNG) into T3 Code's themes folder.
# Checks both files first and backs up any different existing copy with a timestamp.

# Read the entire installer before running it when piped into a shell.
(
  set -eu
  base="${T3CODE_HOME:-$HOME/.t3}"
  dest="$base/userdata/themes"
  files="shadow-system.json shadow-system.png"

  source_dir=
  if [ -f "$0" ]; then
    source_dir=$(cd "$(dirname "$0")" && pwd)/theme
  fi

  if [ -z "$source_dir" ] || [ ! -f "$source_dir/shadow-system.json" ] || [ ! -f "$source_dir/shadow-system.png" ]; then
    source_dir=$(mktemp -d "${TMPDIR:-/tmp}/shadow-system.XXXXXXXX")
    trap 'rm -f "$source_dir/shadow-system.json" "$source_dir/shadow-system.png"; rmdir "$source_dir"' 0
    remote=https://raw.githubusercontent.com/ArcticSlayy/shadow-system-t3-theme/main/theme
    for f in $files; do curl -fsSL "$remote/$f" -o "$source_dir/$f"; done
  fi

  for f in $files; do
    [ -f "$source_dir/$f" ] || { echo "Missing $source_dir/$f" >&2; exit 1; }
  done

  mkdir -p "$dest"
  echo "Themes folder: $dest"
  stamp=$(date +%Y%m%d-%H%M%S)

  # Stage both files before replacing either installed file.
  for f in $files; do cp "$source_dir/$f" "$dest/.$f.new"; done
  for f in $files; do
    if [ -f "$dest/$f" ] && ! cmp -s "$dest/.$f.new" "$dest/$f"; then
      cp "$dest/$f" "$dest/$f.bak-$stamp"
      echo "Existing $f differed; saved as $f.bak-$stamp"
    fi
  done
  for f in $files; do mv -f "$dest/.$f.new" "$dest/$f"; echo "Installed $f"; done

  echo "Done. In T3 Code open Settings > Appearance > Themes and pick 'Shadow Monarch: System' (dark mode)."
  echo "Don't import it with 'Add theme': themes imported there don't get their background image."
)
