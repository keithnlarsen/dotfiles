# dotfiles

Lean terminal IDE — **Alacritty + tmux + Neovim** — with a Dracula "darker" theme,
LSP/intellisense, a diff viewer, and a two-size `ide` layout — `large` (5-pane: editor · two
shells · pinned cheatsheet · AI agent) for the 5K monitor, `small` (4-pane: editor · one
shell · full-height AI agent, no pinned cheatsheet) for the laptop.

## Layout

```
config/alacritty/   → ~/.config/alacritty   GPU terminal, JetBrainsMono Nerd Font
config/tmux/        → ~/.config/tmux         prefix Ctrl-a, statusbar, prefix ? cheatsheet
config/nvim/        → ~/.config/nvim         hand-rolled (lazy.nvim as manager only)
local/bin/ide       → ~/.local/bin/ide       IDE launcher (ide [small|large] [dir])
zsh/ide.zsh         → sourced from ~/.zshrc  PATH, EDITOR, aliases, fzf
```

`install.sh` symlinks these into place, so `~/.config/nvim` is a symlink to
`~/Development/dotfiles/config/nvim`. Edit files in either place — they're the same inode.

## Install (this or a new machine)

This repo's root is `~/Development` (it also hosts sibling project repos, which are
`.gitignore`d). Clone it there, then run the installer:

```sh
git clone <repo-url> ~/Development
~/Development/dotfiles/install.sh
```

`install.sh` is idempotent: correct links are left alone, and anything it would
overwrite is moved to `~/.dotfiles-backup/<timestamp>/` first.

### Dependencies

```sh
brew install alacritty tmux neovim fzf fd ripgrep lazygit bat
brew install --cask font-jetbrains-mono-nerd-font
```

Neovim bootstraps its own plugins via `lazy.nvim` on first launch; LSP servers are
installed with `:Mason`.

## Keys

`prefix` = `Ctrl-a`, leader = `Space`. Full reference: **`prefix ?`** (tmux popup),
or the pinned top-right pane in the `ide` layout. In nvim, press `Space` and wait for
the which-key menu.
