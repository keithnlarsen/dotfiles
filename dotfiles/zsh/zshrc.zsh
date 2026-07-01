# zshrc.zsh — managed shell rc, sourced from the thin ~/.zshrc bootstrap.
# Machine-specific lines (custom PATH exports, tokens, etc.) stay in ~/.zshrc
# ABOVE the source line and are never committed here.

# oh-my-zsh (theme disabled — Starship renders the prompt instead)
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

# Terminal IDE environment (PATH, EDITOR, aliases, fzf)
[ -f "$HOME/Development/dotfiles/zsh/ide.zsh" ] && source "$HOME/Development/dotfiles/zsh/ide.zsh"

# Starship prompt (config: ~/.config/starship.toml, symlinked from dotfiles)
eval "$(starship init zsh)"
