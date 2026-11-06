---
name: herdr
description: Working inside the Herdr app and herdr-core (hc). Use when starting, messaging, waiting on, reading or cleaning up terminals, background programs or other agents (hc run/send/wait/read/kill); when changing what the Herdr window shows (spaces, tabs, panes, layouts, keys, themes, mods; herdr-app do/ls/status/shot); or when editing Herdr's config files.
---

# Herdr

You are probably running in a Herdr terminal: `$HC_TERMINAL_ID` is set (your terminal's
address, not a pane id). Herdr has two parts, each with its own manual printed by the
installed version. Read the manual before acting; don't rely on memory, it changes.

- **Terminals, programs and agents → `hc --skill`.** herdr-core runs every terminal and keeps
  it alive. Use `hc` to start (`hc run --bg`), message (`hc send`), wait (`hc wait`), read
  (`hc read`) and clean up (`hc kill`, `hc rm`) — only terminals you started.
- **What the person sees → `herdr-app --skill`.** Spaces, tabs, panes, layouts, keys, mods
  (`herdr-app ls`, `status`, `do <command>`, `commands`, `shot`). Change only what was asked.
- **Herdr's files → read `AGENTS.md` in Herdr's home first.** It explains layouts, keys.json,
  settings.json, themes and mods, and how to check them (`herdr-app check`, `*.error` files).

## When the manual doesn't say

The manuals leave things out. Something not documented doesn't mean Herdr can't do it.
Don't answer from a gap in the docs; look further, in this order:

- **Latest manual:** https://github.com/herdrdev/herdr-app/blob/master/defaults/AGENTS.md
  (raw: `https://raw.githubusercontent.com/herdrdev/herdr-app/master/defaults/AGENTS.md`).
  Every command, file and setting. It's often newer than the copy in Herdr's home.
- **Source:** https://github.com/herdrdev has the app (`herdr-app`), `herdr-core` and every
  shipped mod, and it's always more current than any manual. Search it (`gh search code
  --owner herdrdev ...`, or the raw files) to see how something really behaves.
- **The installed app:** run it and look: `herdr-app do <command>`, then
  `herdr-app status | cat`. Run `herdr-app commands | cat` to list every command's arguments.

If none of these settles it, say it's unverified; never state a guess as fact. Past
mistakes: keys.json does bind key sequences (`"ctrl-f v": "pane.split:right"`, a GPUI
keymap feature AGENTS.md doesn't mention), and `tab.new` opens the tab right after the
current one, not at the end.

## This setup (Windows app, WSL shell)

- Herdr runs on Windows; this shell is WSL. Herdr's home is
  `/mnt/c/Users/<user>/.config/herdr-app/` (edits there apply live).
- `herdr-app` is a symlink in `~/.local/bin` to the Windows `herdr-app.exe`. It's a GUI
  program: its output only shows when piped, so read it through a pipe
  (`herdr-app status | cat`); captured output is fine. Never hard-code the .exe path.
- `hc` in WSL talks to this distro's core; Herdr reaches it as machine `wsl`, so the app shows
  these terminals as `wsl/t12` while `hc` here wants `t12`.
- The user's personal Herdr files are mirrored in `~/.dotfiles/.config/herdr-app/`. After
  changing Herdr's files, run `mise run herdr:pull` in `~/.dotfiles` so the copy follows
  (`herdr:push` goes the other way). Scripts: `~/.dotfiles/bin/herdr-*`.
- Codex must run with `--no-daemon` inside Herdr, or its commands run outside hc.
