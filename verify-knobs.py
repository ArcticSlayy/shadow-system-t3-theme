"""Verify the knobs migration against HEAD or an explicitly supplied base ref."""

import argparse
import json
import subprocess
from itertools import zip_longest
from pathlib import Path


THEME = "theme/shadow-system.json"
COMMENT = "/* Knobs: change these to tune the theme. See docs/CUSTOMIZE.md */"
DEFAULTS = {
    "--sl-specks": (".6", 1),
    "--sl-blink": ("18s", 2),
    "--sl-wave": ("2.4s", 1),
    "--sl-watch": ("1.45", 1),
    "--sl-shade1": (".40", 1),
    "--sl-shade2": (".58", 1),
    "--sl-shade3": (".56", 1),
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("base", nargs="?", default="HEAD")
    args = parser.parse_args()

    root = Path(__file__).resolve().parent
    baseline = subprocess.check_output(["git", "show", f"{args.base}:{THEME}"], cwd=root)
    original = json.loads(baseline)["css"].encode("utf-8")
    css = json.loads((root / THEME).read_text(encoding="utf-8"))["css"]

    print(f"CSS length: {len(css):,} characters")
    backslashes = css.count("\\")
    print(f"Backslashes in CSS: {backslashes}")
    if len(css) >= 100_000 or backslashes:
        raise SystemExit("CSS exceeds the length or backslash limit")

    declarations = ";".join(f"{name}:{literal}" for name, (literal, _) in DEFAULTS.items())
    prefix = f"{COMMENT}\n:root{{{declarations}}}\n"
    if not css.startswith(prefix):
        raise SystemExit("CSS does not begin with the expected knobs block")

    restored = css[len(prefix):]
    for name, (literal, expected) in DEFAULTS.items():
        reference = f"var({name})"
        count = restored.count(reference)
        if count != expected:
            raise SystemExit(f"{reference}: expected {expected} references, found {count}")
        restored = restored.replace(reference, literal)

    result = restored.encode("utf-8")
    if original != result:
        for offset, (before, after) in enumerate(zip_longest(original, result)):
            if before != after:
                raise SystemExit(f"First difference at byte {offset}: original={before}, restored={after}")

    print("IDENTICAL")


if __name__ == "__main__":
    main()
