# Shadow System theme

## Install

- Back up both installed files before changing either one.
- Copy `theme/shadow-system.json` and `theme/shadow-system.png` into the themes folder. Keep both filenames.
- Use `%USERPROFILE%\.t3\userdata\themes` on Windows and `~/.t3/userdata/themes` elsewhere. If `T3CODE_HOME` is set, use `$T3CODE_HOME/userdata/themes`.
- Never use **Settings → Add theme**. It drops the wallpaper.
- Pick **Shadow Monarch: System** in **Settings → Appearance** with the color scheme set to **Dark**.

## Customize

- Use the [knobs block](docs/CUSTOMIZE.md#knobs) at the start of `css` to adjust specks, timing, typing brightness, and wallpaper shading.
- Keep the decoded `css` under 100,000 characters and free of backslashes. T3 drops declarations that contain backslashes.
- Never put `!important` on a property that a keyframe animates. It stops the animation from controlling that property.
- Move or remove the eye and army overlays when replacing the art. Their positions are pinned to the original image's pixel coordinates. See [Live layers](docs/CUSTOMIZE.md#live-layers).
- Attach visuals to `[data-workspace-area="conversation"]` or its `> :last-child`. The `[data-chat-canvas]` selector sits in a hidden subtree and never paints.
- Verify on screen after every change. Check the wallpaper, text readability, and any affected live layers.
- Keep it cheap: animations on the 125 ms grid with steps() counted per keyframe segment; animate only opacity/transform; never animate custom properties; give transformed pseudo-elements display:inline-block or block.
- Context fill is now a GATE rank in the header chip: "◆ <state> · <X>-rank Gate" (0-9% E ... 75-100% S; Red Gate at T3's red stage).
- Hunter ranks moved to the reasoning-effort picker: rank pills, laser underline, stepped sheen; colors E steel #6b7385 ... MONARCH black core with #8cc4ff edge.
- Effort rows are ranked by position (T3 gives no value attribute).
