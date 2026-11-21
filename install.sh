#!/bin/sh
# Installs the Shadow System theme into T3 Code's themes folder. Never deletes anything.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
base="${T3CODE_HOME:-$HOME/.t3}"
dest="$base/userdata/themes"

mkdir -p "$dest"
echo "Themes folder: $dest"
for f in shadow-system.json shadow-system.png; do
  src="$here/theme/$f"
  [ -f "$src" ] || { echo "Missing $src" >&2; exit 1; }
  if [ -f "$dest/$f" ] && ! cmp -s "$src" "$dest/$f"; then
    cp "$dest/$f" "$dest/$f.bak"
    echo "Existing $f differed; saved as $f.bak"
  fi
  cp "$src" "$dest/$f"
  echo "Copied $f"
done
echo "Done. In T3 Code open Settings > Appearance > Themes and pick 'Shadow Monarch: System'."
