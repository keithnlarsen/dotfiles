# ── Dev environment: tmux + nvim + alacritty ───────────────────────────────
# Sourced from ~/.zshrc.  Managed by ~/.dotfiles (run install.sh to (re)link).
export PATH="$HOME/.local/bin:$PATH"   # for the `dev` layout launcher
export EDITOR="nvim"
export VISUAL="nvim"
alias v="nvim"
alias vim="nvim"
alias lg="lazygit"
# fzf shell integration: Ctrl-T (files), Ctrl-R (history), Alt-C (cd)
command -v fzf >/dev/null && source <(fzf --zsh)
