# dotfiles — terminal IDE

Child of the DOX root (`../AGENTS.md`). Owns Keith's hand-rolled terminal IDE configuration:
**Ghostty + tmux + Neovim**, the `ide` launcher, and the zsh integration. A proper project,
actively enhanced — not just static config.

## Purpose

Single source of truth for the terminal IDE that replaced VS Code. Lean and hand-written (no
distro). The Dracula "darker" 16-color palette is the cohesion source — Ghostty's palette flows
into tmux, nvim, and the agent/terminal panes.

## Ownership

- `config/ghostty/` — GPU terminal (replaced Alacritty; renders Nerd Font powerline glyphs cleanly). `config` + `themes/dracula-darker` (the palette source of truth). `command` launches `~/.local/bin/ide` (builds or reattaches the IDE), dropping to a plain login `zsh` on detach.
- `config/tmux/` — `tmux.conf` (prefix `Ctrl-a`, vi copy-mode), the 4-column cheatsheet generator `cheatsheet.sh`, and the pinned-pane variant `cheatsheet-pinned.sh` (re-renders on SIGWINCH).
- `config/nvim/` — from-scratch Neovim: `init.lua`, `lua/config/{options,keymaps,lazy}.lua`, one file per concern in `lua/plugins/`. `lazy.nvim` is manager only. Leader = Space. `lazy-lock.json` pins plugin versions.
- `config/git/` — XDG git dir: global `ignore` (`~/.config/git`).
- `config/starship.toml` — Starship prompt config (`~/.config/starship.toml`). Starship is the prompt engine (replaced Powerlevel10k); it's a brew binary, not an oh-my-zsh theme.
- `local/bin/ide` — the IDE layout launcher. Two layouts picked by first arg: `large` (default, 5K 45" monitor — 5-pane: nvim, two shells, pinned cheatsheet, agent) and `small` (laptop — 4-pane: nvim, one shell, full-height agent column, no pinned cheatsheet — reach it via the `prefix ?` popup). `small` runs as its own `<dir>-small` session so it coexists with `large`. Usage: `ide [small|large] [dir]` (bare `ide` = `large` at `~/Development`). Names the window `IDE (<focused pane's command>)` via a per-window `automatic-rename-format` (e.g. `IDE (nvim)`, `IDE (claude)`); reattaches if the session already exists.
- `zsh/` — shell config. `zshrc.zsh` (managed rc: framework-free — native `compinit` + history/setopt blocks, sources ide.zsh, then `starship init zsh`) is sourced by the thin `~/.zshrc` bootstrap. `ide.zsh` (PATH, `EDITOR`/`VISUAL=nvim`, aliases, fzf) is sourced by `zshrc.zsh`. `zprofile` → `~/.zprofile`.
- `git/gitconfig` → `~/.gitconfig` — home-level git config (user, credential helper via `gh`; no tokens).
- `install.sh` — idempotent symlinker (see Local Contracts). `README.md` — human setup notes.

## Local Contracts

- **The symlink seam.** Real files live here; `install.sh` symlinks them into `~/.config/{tmux,nvim,ghostty,git,starship.toml}`, `~/.local/bin/ide`, and the home-level dotfiles `~/.zprofile`, `~/.gitconfig` — backing up anything it replaces to `~/.dotfiles-backup/<ts>/`. Editing the repo file or its symlink is the same inode. Prefer editing the repo path.
- **`.zshrc` is the one non-symlinked file** (bootstrap seam): it stays a thin `~/.zshrc` that keeps machine-specific lines (custom PATH exports) and sources `zsh/zshrc.zsh`. Never move machine-specific/secret lines into the repo; they live only in `~/.zshrc`.
- **After moving/renaming files** under `config/`, `zsh/`, `git/`, or `local/bin`, update `install.sh`'s `link` calls and re-run it so the symlinks track. After changing the `~/.zshrc` source path, keep `install.sh`'s grep guard + write block in sync.
- **bash 3.2 portability** (macOS): the cheatsheet scripts set `LC_ALL=en_US.UTF-8` so `${#str}` counts characters, keeping column dividers aligned.
- **Public repo** (`keithnlarsen/dotfiles`): secret-scan before any push. Never manage credential/state files — `.git-credentials`, `~/.config/{gh,gcloud}`, `.zsh_history`, `.claude.json` stay out of the repo.

## Work Guidance

- Keep the Dracula palette the single point of color truth — don't hardcode colors per-tool when they can inherit from Ghostty's 16-color set (`config/ghostty/themes/dracula-darker`).
- **No GitHub issues for dotfiles work.** The root DOX's "issue before large tasks" preference does not apply here — just do the work and commit. Push directly to `main` when Keith asks.

## Verification

- After config changes: `bash install.sh` (idempotent — re-links only what drifted), then open a new shell / reload the affected app (tmux `prefix r`, nvim restart, Ghostty reloads with `Cmd+Shift+,`).
- Validate a Ghostty config edit: `/Applications/Ghostty.app/Contents/MacOS/ghostty +show-config` (exits non-zero and prints the offending key on error).
