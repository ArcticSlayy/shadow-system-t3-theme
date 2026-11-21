# Customizing Shadow System

Everything lives in two files in your T3 Code themes folder: `shadow-system.json` and `shadow-system.png` (see the README for where that folder is). Back up both before you edit. After you save, re-pick the theme in **Settings → Appearance** if the change doesn't show.

You can also ask a T3 agent to make any of these changes for you. Name the theme (`shadow-system`) and what you want, in plain words.

## How T3 themes work (worth knowing first)

- A theme in the **themes folder** can have a background image: `<theme id>.png` (or `.jpg`/`.webp`, up to 16 MB) next to the JSON. The CSS shows it through `var(--theme-background-image)`.
- Themes added with **Settings → Appearance → Add theme**, or made in **Create theme**, are saved in the app's own list instead. **Those never load a background image.** Keep this theme as files in the folder.
- **Create theme is still useful for picking colors.** It edits the palette roles (Background, Surface, Text, Border and so on) with a live preview. Try colors there, then copy the hex values into `colors` in `shadow-system.json`.
- The `css` field is limited to 100,000 characters (this theme uses about 77k). T3 drops any CSS declaration that contains a backslash, and allows `url()` only for `data:` URIs.
- T3 documents a set of stable selectors (`[data-workspace-area="conversation"]`, `[data-chat-header]`, `[data-slot="composer-host"]`, `.chat-markdown` and others). Other class names can change between releases.

## Colors

**Palette (`colors` in the JSON):** these set the app's native colors.

| Role | Value |
|---|---|
| `canvas`, `chrome` | `#020306` |
| `surface` / `surfaceRaised` / `surfaceOverlay` | `#04070c` / `#080d13` / `#0b121b` |
| `text` / `textMuted` / `placeholder` | `#e4ebf5` / `#909eb3` / `#7f8ca3` |
| `border`, `input` | `#162234` |
| `accent`, `focus` | `#3d8bff` |
| `error` / `warning` | `#ff4d63` / `#ffcf6b` |

**Accent variables (in `css`, on `:root`):**

| Variable | What it is | Default |
|---|---|---|
| `--ac` | main accent | `#3d8bff` |
| `--ac2` | light accent (labels, brackets) | `#8cc4ff` |
| `--acs` / `--acb` / `--acg` | accent surface / border / glow | `#0a1a33` / `#16345e` / `rgba(61,139,255,.45)` |
| `--sac*` | the same set, for the sidebar | |

When the context window reaches amber or red, these variables switch to amber (`#ffb347`) or red (`#ff4d63`). The B- and A-rank stages tint `--ac` slightly. **To recolor the whole theme,** find and replace the blue hex values across all of `css`. Editing only the first `:root` rule leaves the stage and rank overrides blue.

## Text and labels

| What | How to change it |
|---|---|
| Header chip text | `--hdr`: "System online", "Quest active" (agent working), "Awaiting orders" (question waiting), "Mana low" (amber), "Penalty zone" (red) |
| Rank names | `--rk`, set by context-window fill: 0–9% E-rank, 10–24% D-rank, 25–44% C-rank, 45–59% B-rank, 60–74% A-rank, 75–79% S-rank, 80–89% National-level, 90–96% Monarch, 97–100% Shadow Monarch |
| Label font | `--sysfont` (Bahnschrift, then Segoe UI) |
| Labels | Search `css` for `[ SYSTEM ]`, `[ QUEST COMPLETE ]`, `[ NOTIFICATION ]`, `HUNTER` (your messages) and `COMMAND` (composer), and edit the `content:` text |

## Background art

- **Swap the image:** replace `shadow-system.png`. The theme was composed for **1920x1080**, with the figure on the left and a quiet right side so text stays readable. The image is anchored to the bottom left and scaled to cover the chat area.
- **Readability shading:** the chat area's `background` starts with a dark left-to-right gradient, darkest in the middle where the text sits (`.40` at 26%, `.58` at 44%, `.56` at 68%). Raise those numbers for more contrast, or lower them to show more of the art.
- **The glowing eyes and the army** are drawn on top, at fixed pixel positions in this art. If you use your own image, remove or move those layers (next section). Otherwise you'll get glows in odd places.

## Live layers

The overlays are positioned in image pixels converted to screen size: x maps to `calc(M * x / 1080)` and y to `calc(M * (1080 - y) / 1080)` from the bottom, where `M = max(100cqh, 56.25cqw)` is the drawn image height.

| Layer | Selector | Behavior | Knobs |
|---|---|---|---|
| Hood's eyes and the figure's glint | `[data-workspace-area="conversation"]::before` | The red eyes breathe at idle (`slEye 8s`). A heartbeat (`slBeat`) plays while an agent works, a question waits, or context is amber/red. Typing sets `--watch: 1.45`, which brightens the eyes and shows a small blue glint on each of the figure's eyes. | `--beatT` = heartbeat period: 9s idle, 3s working, 1.5s with a question, 6s amber, 3.6s red |
| Distant army | `[data-workspace-area="conversation"]::after` | 14 soldier glints. At idle, one soldier opens its eyes every ~2.6s (`slWink 18s`). Working, a waiting question, or hovering Send sets `--army: 1`, and the eyes light in a wave outward from the figure. | the blink cycle `18s`; the wave speed is the `--army` transition, `2.4s` |
| Floating specks | `[data-workspace-area="conversation"] > :last-child::after` | Specks drift up the left 46% of the chat, behind the text. | `opacity: .6`; delete the rule to turn them off |

All background animation sits inside `@media (prefers-reduced-motion: no-preference)`, so the OS "reduce motion" setting turns it off.

**To turn something off:** delete its rule, or set `animation: none` on it. Don't add `!important` to a property that a keyframe animates, or the animation stops working.

## Other styled parts (search `css` for these)

- **Header chip:** `[data-chat-header]::after`. It hides on windows 1300px wide or less.
- **Send button:** `button[aria-label="Submit message"]`, a rotated diamond with a slow pulse. The Stop button is the red version.
- **Panels:** the composer, details card, dialogs, command palette and menus use the 12px corner brackets in `--brk`. Dialogs, the palette and menus "unfold" from a line (`slUnfold`).
- **Usage bars:** blue by default, amber under 10% left, red at 0%.

## Can't be changed with CSS

The native right-click menu, terminal text, the file tree, diff internals, and a few hard-coded strings ("Open a surface", "Search…"). The mobile app doesn't use themes.
