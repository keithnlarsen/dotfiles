# dotfiles

Keith's `~/Development` — a hand-rolled **terminal IDE** (Alacritty + tmux + Neovim,
the lean replacement for VS Code) plus the `AGENTS.md` docs that steer AI coding agents
working anywhere in this tree.

The git repo is rooted at `~/Development` itself: it tracks the top-level docs and the
[`dotfiles/`](dotfiles/) project, while sibling project repos (`piidesk/`, `markov/`) live
alongside as independent git repos and are `.gitignore`d.

## What's here

```
AGENTS.md     DOX root — cross-project context + the DOX framework (agent contract)
CLAUDE.md     entry point that points Claude Code at AGENTS.md
dotfiles/     the terminal IDE: Alacritty · tmux · Neovim · the `ide` launcher · zsh
  ├ config/     real config files (install.sh symlinks them into ~/.config)
  ├ local/bin/  the `ide` launcher
  ├ install.sh  idempotent symlinker
  └ README.md   setup + usage detail  ←  start here to install
piidesk/      sibling project — own git repo, .gitignore'd
markov/       sibling project — own git repo, .gitignore'd
```

## The terminal IDE

One command, `ide`, builds a 5-pane tmux layout — editor · two shells · pinned cheatsheet ·
AI agent — themed with Dracula "darker", with LSP/intellisense and a git diff viewer in
Neovim. `prefix` = `Ctrl-a`, leader = `Space`; press **`prefix ?`** for the full keybinding
cheatsheet. Alacritty opens maximized and launches straight into `ide`.

See [`dotfiles/README.md`](dotfiles/README.md) for the layout map, keybindings, and dependencies.

## Quick start

```sh
git clone https://github.com/keithnlarsen/dotfiles.git ~/Development
~/Development/dotfiles/install.sh
```

`install.sh` is idempotent and safe: it leaves correct symlinks alone and backs up anything
it would overwrite to `~/.dotfiles-backup/<timestamp>/`. Dependencies and per-tool notes are
in [`dotfiles/README.md`](dotfiles/README.md).

## DOX — the agent contract

`AGENTS.md` files form a hierarchy ("DOX"): the root carries cross-project context and global
rules, and each project (e.g. [`dotfiles/AGENTS.md`](dotfiles/AGENTS.md)) owns its own subtree.
An agent reads the chain from the root down to whatever it's about to edit, treats the nearest
file as the local contract, and updates the affected docs as part of finishing the work.
