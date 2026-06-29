# dotfiles — terminal IDE

Child of the DOX root (`../AGENTS.md`). Owns Keith's hand-rolled terminal IDE configuration:
**Alacritty + tmux + Neovim**, the `ide` launcher, and the zsh integration. A proper project,
actively enhanced — not just static config.

## Purpose

Single source of truth for the terminal IDE that replaced VS Code. Lean and hand-written (no
distro). The Dracula "darker" 16-color palette is the cohesion source — Alacritty's palette flows
into tmux, nvim, and the agent/terminal panes.

## Ownership

- `config/alacritty/` — GPU terminal: `alacritty.toml` + `themes/dracula-darker.toml`. Auto-launches tmux session `main`.
- `config/tmux/` — `tmux.conf` (prefix `Ctrl-a`, vi copy-mode), the 4-column cheatsheet generator `cheatsheet.sh`, and the pinned-pane variant `cheatsheet-pinned.sh` (re-renders on SIGWINCH).
- `config/nvim/` — from-scratch Neovim: `init.lua`, `lua/config/{options,keymaps,lazy}.lua`, one file per concern in `lua/plugins/`. `lazy.nvim` is manager only. Leader = Space. `lazy-lock.json` pins plugin versions.
- `local/bin/ide` — the IDE layout launcher (4-pane: nvim, shell, pinned cheatsheet, agent). Roots at `~/Development` by default; pass a dir to override.
- `zsh/ide.zsh` — PATH, `EDITOR`/`VISUAL=nvim`, aliases, fzf integration. Sourced from `~/.zshrc` (not symlinked — that file holds oh-my-zsh / p10k).
- `install.sh` — idempotent symlinker (see Local Contracts). `README.md` — human setup notes.

## Local Contracts

- **The symlink seam.** Real files live here; `install.sh` symlinks them into `~/.config/{alacritty,tmux,nvim}` and `~/.local/bin/ide`, backing up anything it replaces to `~/.dotfiles-backup/<ts>/`. Editing the repo file or its `~/.config` symlink is the same inode. Prefer editing the repo path.
- **After moving/renaming files** under `config/` or `local/bin`, update `install.sh`'s `link` calls and re-run it so the symlinks track. After editing the `~/.zshrc` source path, keep `install.sh`'s grep guard + write block in sync.
- **bash 3.2 portability** (macOS): the cheatsheet scripts set `LC_ALL=en_US.UTF-8` so `${#str}` counts characters, keeping column dividers aligned.
- **Public repo** (`keithnlarsen/dotfiles`): secret-scan before any push.

## Work Guidance

- Keep the Dracula palette the single point of color truth — don't hardcode colors per-tool when they can inherit from Alacritty's 16-color set.

## Verification

- After config changes: `bash install.sh` (idempotent — re-links only what drifted), then open a new shell / reload the affected app (tmux `prefix r`, nvim restart, Alacritty live-reloads).
