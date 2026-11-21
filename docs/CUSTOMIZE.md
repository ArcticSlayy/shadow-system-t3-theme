# Customizing Shadow System

Everything lives in two files in your T3 Code themes folder: `shadow-system.json` and `shadow-system.png` (see the README for where that folder is). Back up both before you edit. After you save, re-pick the theme in **Settings → Appearance** if the change doesn't show.

You can also ask a T3 agent to make any of these changes for you. Name the theme (`shadow-system`) and what you want, in plain words.

## How T3 themes work (worth knowing first)

- A theme in the **themes folder** can have a background image: `<theme id>.png` (or `.jpg`/`.webp`, up to 16 MB) next to the JSON. The CSS shows it through `var(--theme-background-image)`.
- Themes added with **Settings → Appearance → Add theme**, or made in **Create theme**, are saved in the app's own list instead. **Those never load a background image.** Keep this theme as files in the folder.
- **Create theme is still useful for picking colors.** It edits the palette roles (Background, Surface, Text, Border and so on) with a live preview. Try colors there, then copy the hex values into `colors` in `shadow-system.json`.
- The `css` field is limited to 100,000 characters (this theme uses about 77k). T3 drops any CSS declaration that contains a backslash, and allows `url()` only for `data:` URIs.
- T3 documents a set of stable selectors (`[data-workspace-area="conversation"]`, `[data-chat-header]`, `[data-slot="composer-host"]`, `.chat-markdown` and others). Other class names can change between releases.

## Knobs

Edit the first `:root` rule in `css` to tune these settings.

| Knob | What it does | Default |
|---|---|---|
| `--sl-specks` | Floating speck opacity. Set to `0` to hide them. | `.6` |
| `--sl-wave` | Length of the army's wake-up transition. | `2.4s` |
| `--sl-watch` | Eye brightness while drafting. | `1.45` |
| `--sl-shade1` | Chat background shade opacity at 26%. | `.40` |
| `--sl-shade2` | Chat background shade opacity at 44%. | `.58` |
| `--sl-shade3` | Chat background shade opacity at 68%. | `.56` |

## Effort picker

Selectors: `[data-chat-composer-form] [data-chat-provider-model-picker]` (using aria-label) and `[data-model-picker-effort] [role="radiogroup"] > [data-effort-level]`. Per-rank variables: `--t` (label), `--c` (color), `--a` (strength 22-100), `--sd`/`--st` (sheen duration and steps). Colors follow the System-window palette: E steel #6b7385, D #6a8fc8, C #3d8bff, B #34a9ff, A #39d3ff, S ice-white #f2fbff, MONARCH black core with #8cc4ff edge.

## Keep it cheap

- Animations on the 125 ms grid with steps() counted per keyframe segment.
- Animate only opacity/transform.
- Never animate custom properties.
- Give transformed pseudo-elements display:inline-block or block.

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
| Context (GATE rank) | The header chip reads "◆ <state> · <X>-rank Gate": 0-9% E, 10-24% D, 25-44% C, 45-59% B, 60-74% A, 75-100% S; at T3's red context stage it reads "Red Gate". States: System online / Quest active (working) / Awaiting orders (question) / Mana low (amber) / Penalty zone (red). At red the assistant label reads "[ DUNGEON BREAK ]" and the details card "[ PENALTY ZONE ]". |
| Label font | `--sysfont` (Bahnschrift, then Segoe UI) |
| Labels | Search `css` for `[ SYSTEM ]`, `[ QUEST COMPLETE ]`, `[ NOTIFICATION ]`, `HUNTER` (your messages) and `COMMAND` (composer), and edit the `content:` text |

## Background art

- **Swap the image:** replace `shadow-system.png`. The theme was composed for **1920x1080**, with the figure on the left and a quiet right side so text stays readable. The image is anchored to the bottom left and scaled to cover the chat area.
- **Readability shading:** the chat area's background uses a dark left-to-right gradient. Raise `--sl-shade1`, `--sl-shade2`, and `--sl-shade3` for more contrast, or lower them to show more of the art.
- **The glowing eyes and the army** are drawn on top, at fixed pixel positions in this art. If you use your own image, remove or move those layers (next section). Otherwise you'll get glows in odd places.

## Live layers

The overlays are positioned in image pixels converted to screen size: x maps to `calc(M * x / 1080)` and y to `calc(M * (1080 - y) / 1080)` from the bottom, where `M = max(100cqh, 56.25cqw)` is the drawn image height.

| Layer | Selector | Behavior | Knobs |
|---|---|---|---|
| Hood's eyes and the figure's glint | `[data-workspace-area="conversation"]::before` | Drawn as animated SVG images (data URIs); one SVG per state, switched by CSS. Eyes breathe at idle, heartbeat while working, brighter with a small blue glint on the figure's eyes while typing. | `--sl-watch` typing brightness |
| Distant army | `[data-workspace-area="conversation"]::after` | Drawn as animated SVG images (data URIs); one SVG per state, switched by CSS. At idle one soldier opens its eyes about every 2.6s; working / question / Send-hover: a wave lights them outward from the figure, then they pulse with the heartbeat. `--sl-blink` removed (blink rhythm baked into the army SVG). | `--sl-wave` |
| Floating specks | `[data-workspace-area="conversation"] > :last-child::after` | Specks drift up the left 46% of the chat, behind the text. | `--sl-specks` |

All background animation sits inside `@media (prefers-reduced-motion: no-preference)`, so the OS "reduce motion" setting turns it off.

**To turn something off:** delete its rule, or set `animation: none` on it. Don't add `!important` to a property that a keyframe animates, or the animation stops working.

## Other styled parts (search `css` for these)

- **Header chip:** `[data-chat-header]::after`. It hides on windows 1300px wide or less.
- **Send button:** `button[aria-label="Submit message"]`, a rotated diamond with a slow pulse. The Stop button is the red version.
- **Panels:** the composer, details card, dialogs, command palette and menus use the 12px corner brackets in `--brk`. Dialogs, the palette and menus "unfold" from a line (`slUnfold`).
- **Usage bars:** blue by default, amber under 10% left, red at 0%.

## Can't be changed with CSS

The native right-click menu, terminal text, the file tree, diff internals, and a few hard-coded strings ("Open a surface", "Search…"). The mobile app doesn't use themes.
