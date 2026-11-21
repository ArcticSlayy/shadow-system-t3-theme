<div align="center">

<img src="docs/banner.png" alt="Shadow System - a T3 Code theme" width="100%">

### An OLED-black "System window" for T3 Code, and it reacts to what your agents are doing.

![T3 Code theme](https://img.shields.io/badge/T3_Code-theme-3d8bff?style=flat-square)
![dark](https://img.shields.io/badge/appearance-dark-020306?style=flat-square&labelColor=162234)
![OLED](https://img.shields.io/badge/OLED-black-000000?style=flat-square&labelColor=162234)
![reduced motion aware](https://img.shields.io/badge/reduced--motion-aware-3d8bff?style=flat-square)
![no blur](https://img.shields.io/badge/backdrop_blur-none-162234?style=flat-square)
![MIT code](https://img.shields.io/badge/code-MIT-3d8bff?style=flat-square)

Made by **[@ArcticSlayy](https://github.com/ArcticSlayy)**

**[Screenshots](#screenshots)** · **[What reacts](#what-reacts-to-what)** · **[Install](#install)** · **[Ask your agent](#or-just-ask-your-t3-agent)** · **[Customize](#customize)**

</div>

---

**Shadow System** (`shadow-system`) is a dark theme for the T3 Code desktop app, inspired by the blue "System" windows of *Solo Leveling*. Near-black surfaces, one vivid blue accent (no purple anywhere, even project icons are remapped), Segoe UI, and a hooded-figure painting behind the chat.

The art is not just wallpaper. Its glowing eyes, the distant army, the header chip and the usage bars all follow live app state: working, waiting on a question, typing, hovering Send, and how full the context window is.

## Screenshots

<p align="center">
  <img src="docs/screenshots/new-thread.png" alt="New thread screen with hooded figure art and the command composer" width="100%"><br>
  <sub>New thread, idle: hero label, command composer, the hooded figure and the army on the horizon.</sub>
</p>

<p align="center">
  <img src="docs/screenshots/typing.png" alt="The same screen with the word Arise typed into the composer" width="100%"><br>
  <sub>Typing a message: the hood's eyes brighten, the small figure's eyes glint, and Send lights up.</sub>
</p>

<p align="center">
  <img src="docs/screenshots/eyes-idle-vs-typing.png" alt="Close-up of the hooded figure's eyes, idle on the left and typing on the right" width="100%"><br>
  <sub>Detail: idle (left) and while typing (right), when the small figure's eyes catch a blue glint.</sub>
</p>

<p align="center">
  <img src="docs/screenshots/soldier-blink.png" alt="The distant army with one soldier's eyes glowing blue" width="100%"><br>
  <sub>Detail: every few seconds one distant soldier opens its eyes.</sub>
</p>

<p align="center">
  <img src="docs/screenshots/settings.png" alt="Settings, Appearance, showing the Themes grid" width="100%"><br>
  <sub>Settings, Appearance: where you pick themes.</sub>
</p>

> The two full-window shots are real app captures. The details are crops: the eyes comparison puts two captures side by side, the blink is enlarged from a capture, and the settings shot has its background pixelated.

## What reacts to what

| When this happens | The theme does this |
|---|---|
| **Idle** | The hood's red eyes breathe slowly. Every few seconds one distant soldier opens its eyes. Blue specks drift up the left side (inside threads). |
| **You type a message** | The hood's eyes brighten and the small figure's eyes glint blue. |
| **You hover Send** | The distant army wakes, eyes lighting in a wave outward from the figure. |
| **An agent is working, or a question is waiting** | A heartbeat pulses in the hood's eyes and the whole army stays awake, pulsing with it. The header chip reads "Quest active" (or "Awaiting orders" for a question) and pulses. The question card itself stays flat and calm. |
| **Context window turns amber or red** | Alert colors on the header chip and meter ("Mana low" at amber, "Penalty zone" at red), and a faster heartbeat. |
| **Context window fills up** | The header chip shows a rank (E-rank upward) as the context fills. |
| **Rank changes** | The rank chip plays a one-shot level-up ping. |
| **A turn finishes** | A `[ QUEST COMPLETE ]` label, plus a sweep on Done rows in the sidebar. |
| **Messages, dialogs, toasts** | Assistant messages carry a `[ SYSTEM ]` label, the new-thread hero types its own `[ SYSTEM ]` label, toasts get `[ NOTIFICATION ]`, and dialogs, the command palette and menus **unfold** from a line into a window. |
| **Usage / quota bars** | Blue by default, amber under 10% left, red at 0%. |

## Install

Copy **both** files into T3 Code's themes folder, then pick the theme.

> **Don't use Settings → Add theme for this one.** T3 doesn't load background images for themes imported through that box, so you'd get the colors without the art. If you already imported it there, remove that copy so the folder version (with the art) is used.

### A. Script (easiest)

From a clone or download of this repo:

```powershell
./install.ps1        # Windows (PowerShell)
```

```sh
sh install.sh        # macOS / Linux
```

Both scripts check both files first, back up any different existing copy with a timestamp, copy the pair, and never delete anything.

### B. By hand

Copy `theme/shadow-system.json` and `theme/shadow-system.png` into the themes folder. Keep the names exactly: the image must be named after the theme id.

| OS | Themes folder | Status |
|---|---|---|
| Windows | `%USERPROFILE%\.t3\userdata\themes\` | Confirmed (on a real install, and in the app's server code) |
| macOS | `~/.t3/userdata/themes/` | Likely: the app builds this path from the home directory with no OS-specific branch, but not tested on a Mac |
| Linux | `~/.t3/userdata/themes/` | Likely: same reasoning, not tested on Linux |

If you set the `T3CODE_HOME` environment variable, the base folder moves there. The install scripts honor it.

### Then pick it

In T3 Code open **Settings → Appearance**, pick **Shadow Monarch: System** under **Themes** for dark mode, and set the color scheme above it to **Dark** (the theme is dark-only). You may need to scroll the grid.

## Or just ask your T3 agent

T3 Code agents can install and restyle themes themselves. Paste this into a thread:

```text
Install the Shadow System theme from https://github.com/ArcticSlayy/shadow-system-t3-theme.
Download theme/shadow-system.json and theme/shadow-system.png from the main branch and
copy both into my T3 Code themes folder (~/.t3/userdata/themes/, or
$T3CODE_HOME/userdata/themes/ if that variable is set). Keep the file names exactly.
Then switch T3 Code to the shadow-system theme in dark mode.
```

Then ask for changes in plain words, for example:

- *"In the shadow-system theme, change the blue accent to green everywhere."*
- *"Turn off the floating specks in the shadow-system theme."*
- *"Use my picture `C:\path\to\art.png` as the shadow-system background and remove the eye and army glows."*

The agent edits `shadow-system.json` in the themes folder. Keep a copy of the original in case you want it back.

## Customize

Everything lives in `theme/shadow-system.json`:

- `colors`: the native palette (`accent`, `surface`, `sidebar`, `error`, ...). Change `#3d8bff` here to retint the app chrome.
- `css`: extra styling. The main knobs are custom properties on `:root`:

| Property | What it controls |
|---|---|
| `--ac` / `--ac2` | Accent and its lighter companion (`#3d8bff` / `#8cc4ff`) |
| `--acs` / `--acb` / `--acg` | Accent surface, border and glow |
| `--sysfont` | Font stack for the System-style labels (Bahnschrift, then Segoe UI) |
| `--hdr` | Header chip text ("System online") |
| `--army`, `--beat`, `--watch` | Live-state dials the animations read: army awake (0 or 1), heartbeat strength, typing brightness |

Heads-up: the amber and red alert stages and each rank bucket **override** `--ac` on purpose. To change the accent everywhere, find-and-replace the blue hex values (`#3d8bff` and friends) across the whole `css` string rather than editing only the first `:root` rule.

**Swap the art:** replace `theme/shadow-system.png` (installed next to the JSON) with your own image. The theme was composed for **1920x1080**, with the figure at the far left and a quiet, dark right side so the UI stays readable. The eye glows are positioned to the shipped art, so with new art expect to move or remove those layers in the CSS.

Notes for CSS tinkerers: T3 caps a theme's CSS at 100k characters (this one is about 77k), and the CSS here contains no backslashes.

## Performance

- The background image itself is static and never repaints.
- The live parts are two small overlay layers over the art. The hood's eyes update about 2.5 times a second at idle. A soldier's blink and the working heartbeat update more often (roughly 7 to 30 times a second), but only over those small areas.
- The specks move with a GPU transform.
- While an agent works, the header chip and the Stop/Send button add small glow animations.
- No backdrop blur anywhere.
- **Reduced motion is respected:** with the OS "reduce motion" setting on, the background animations are off and you get the same look, static.

## Known limits

CSS can't restyle everything:

- The native right-click menu (it is drawn by the OS, not the page).
- Hard-coded strings such as "Open a surface" and "Search...".
- Provider brand colors in the usage cost chart.
- The army sits at the far right of the art. On narrow chat panes it's off-screen (the art is anchored left so the figure always shows).
- The header chip hides on windows 1300px wide or less.
- Specks only show inside threads (the new-thread page has no chat canvas).
- Some effects (toast labels, the Done-row sweep, the amber/red stages on a very long thread) have had less live testing than the rest.

## Credits and disclaimer

- **Made by** [@ArcticSlayy](https://github.com/ArcticSlayy). Issues and PRs welcome.
- **Code** (the theme CSS/JSON and install scripts): [MIT](LICENSE).
- **Background art** (`theme/shadow-system.png`): AI-generated fan art inspired by *Solo Leveling*. It is **excluded from the MIT grant**, is not affiliated with or endorsed by the rights holders of *Solo Leveling*, and will be removed on request. See [`theme/ART-NOTICE.md`](theme/ART-NOTICE.md).
- "T3 Code" and "Solo Leveling" belong to their respective owners. This is an unofficial community theme.
