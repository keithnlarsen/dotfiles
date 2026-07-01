# dotfiles

Lean terminal IDE — **Ghostty + tmux + Neovim** — with a Dracula "darker" theme,
LSP/intellisense, a diff viewer, and a two-size `ide` layout — `large` (5-pane: editor · two
shells · pinned cheatsheet · AI agent) for the 5K monitor, `small` (4-pane: editor · one
shell · full-height AI agent, no pinned cheatsheet) for the laptop.

## Layout

```
config/ghostty/     → ~/.config/ghostty      GPU terminal, JetBrainsMono Nerd Font, launches ide
config/tmux/        → ~/.config/tmux         prefix Ctrl-a, statusbar, prefix ? cheatsheet
config/nvim/        → ~/.config/nvim         hand-rolled (lazy.nvim as manager only)
config/git/         → ~/.config/git          global gitignore (XDG)
config/starship.toml → ~/.config/starship.toml  Starship prompt config
local/bin/ide       → ~/.local/bin/ide       IDE launcher (ide [small|large] [dir])
zsh/zshrc.zsh       → sourced from ~/.zshrc  framework-free rc, sources ide.zsh + starship
zsh/ide.zsh         → sourced by zshrc.zsh   PATH, EDITOR, aliases, fzf
zsh/zprofile        → ~/.zprofile            brew shellenv
git/gitconfig       → ~/.gitconfig           user + gh credential helper
```

`install.sh` symlinks these into place, so `~/.config/nvim` is a symlink to
`~/Development/dotfiles/config/nvim`. Edit files in either place — they're the same inode.

`~/.zshrc` is the one exception — it stays a thin, un-symlinked bootstrap that keeps
machine-specific lines (custom PATH exports) and sources `zsh/zshrc.zsh`. Secrets and
machine state (`.git-credentials`, `~/.config/{gh,gcloud}`, history) are never managed here.

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
brew install tmux neovim fzf fd ripgrep lazygit bat starship gh
brew install --cask ghostty font-jetbrains-mono-nerd-font
```

(`gh` only backs the `github.com` credential helper — optional if you never push to GitHub. If
`~/Development` already exists, init the repo in place instead of cloning. Work machines on
self-hosted GitLab: see `dotfiles/AGENTS.md` → Setup for git identity/auth reconciliation.)

Neovim bootstraps its own plugins via `lazy.nvim` on first launch; LSP servers are
installed with `:Mason`.

## Keys

`prefix` = `Ctrl-a`, leader = `Space`. Full reference: **`prefix ?`** (tmux popup),
or the pinned top-right pane in the `ide` layout. In nvim, press `Space` and wait for
the which-key menu.
