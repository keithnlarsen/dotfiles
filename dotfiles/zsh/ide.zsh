# ── Dev environment: tmux + nvim + alacritty ───────────────────────────────
# Sourced from ~/.zshrc.  Managed by ~/Development/dotfiles (run install.sh to (re)link).
export PATH="$HOME/.local/bin:$PATH"   # for the `ide` layout launcher
export EDITOR="nvim"
export VISUAL="nvim"
alias v="nvim"
alias vim="nvim"
alias lg="lazygit"
# fzf shell integration: Ctrl-T (files), Ctrl-R (history), Alt-C (cd)
command -v fzf >/dev/null && source <(fzf --zsh)
