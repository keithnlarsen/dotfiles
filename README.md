# dotfiles

Lean terminal IDE — **Alacritty + tmux + Neovim** — with a Dracula "darker" theme,
LSP/intellisense, a diff viewer, and a 4-pane `dev` layout (editor · shell · pinned
cheatsheet · AI agent).

## Layout

```
config/alacritty/   → ~/.config/alacritty   GPU terminal, JetBrainsMono Nerd Font
config/tmux/        → ~/.config/tmux         prefix Ctrl-a, statusbar, prefix ? cheatsheet
config/nvim/        → ~/.config/nvim         hand-rolled (lazy.nvim as manager only)
local/bin/dev       → ~/.local/bin/dev       the 4-pane IDE launcher
zsh/piidesk-ide.zsh → sourced from ~/.zshrc  PATH, EDITOR, aliases, fzf
```

The repo mirrors the home layout, so `~/.config/nvim` is a symlink to
`~/.dotfiles/config/nvim`. Edit files in either place — they're the same inode.

## Install (this or a new machine)

```sh
git clone <repo-url> ~/.dotfiles
~/.dotfiles/install.sh
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
or the pinned top-right pane in the `dev` layout. In nvim, press `Space` and wait for
the which-key menu.
