# zshrc.zsh — managed shell rc, sourced from the thin ~/.zshrc bootstrap.
# Machine-specific lines (custom PATH exports, tokens, etc.) stay in ~/.zshrc
# ABOVE the source line and are never committed here.
#
# Lean by design: no framework. Each block is one explicit responsibility.

# ── Completion ───────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit

# ── History ──────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_all_dups hist_reduce_blanks share_history inc_append_history

# ── Shell options ────────────────────────────────────────────────────────────
setopt autocd interactive_comments

# ── Terminal IDE environment (PATH, EDITOR, aliases, fzf) ─────────────────────
[ -f "$HOME/Development/dotfiles/zsh/ide.zsh" ] && source "$HOME/Development/dotfiles/zsh/ide.zsh"

# ── Prompt: Starship (config: ~/.config/starship.toml, symlinked from dotfiles) ─
eval "$(starship init zsh)"
