#!/bin/sh
# Installs the Shadow System theme (JSON + background PNG) into T3 Code's themes folder.
# Checks both files first, backs up any different existing copy with a timestamp, never deletes anything.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
base="${T3CODE_HOME:-$HOME/.t3}"
dest="$base/userdata/themes"
files="shadow-system.json shadow-system.png"

for f in $files; do
  [ -f "$here/theme/$f" ] || { echo "Missing $here/theme/$f" >&2; exit 1; }
done

mkdir -p "$dest"
echo "Themes folder: $dest"
stamp=$(date +%Y%m%d-%H%M%S)

# stage both files first, so a failure can't leave a mismatched pair
for f in $files; do cp "$here/theme/$f" "$dest/.$f.new"; done
for f in $files; do
  if [ -f "$dest/$f" ] && ! cmp -s "$dest/.$f.new" "$dest/$f"; then
    cp "$dest/$f" "$dest/$f.bak-$stamp"
    echo "Existing $f differed; saved as $f.bak-$stamp"
  fi
done
for f in $files; do mv -f "$dest/.$f.new" "$dest/$f"; echo "Installed $f"; done

echo "Done. In T3 Code open Settings > Appearance > Themes and pick 'Shadow Monarch: System' (dark mode)."
echo "Don't import it with 'Add theme': themes imported there don't get their background image."
