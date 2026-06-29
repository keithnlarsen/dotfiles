#!/usr/bin/env bash
# install.sh — symlink this repo's dotfiles into place.
#
# Idempotent and safe: re-running does nothing if links are already correct,
# and anything it would overwrite is moved to a timestamped backup first.
#
#   ~/.dotfiles/config/alacritty  ->  ~/.config/alacritty
#   ~/.dotfiles/config/tmux       ->  ~/.config/tmux
#   ~/.dotfiles/config/nvim       ->  ~/.config/nvim
#   ~/.dotfiles/local/bin/dev     ->  ~/.local/bin/dev
#   ~/.zshrc  gets a `source` line for  ~/.dotfiles/zsh/piidesk-ide.zsh
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {            # link <repo-relative-source> <absolute-target>
  local src="$DOTFILES/$1" dest="$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok      $dest"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP$(dirname "${dest#"$HOME"}")"
    mv "$dest" "$BACKUP${dest#"$HOME"}"
    echo "backup  $dest -> $BACKUP${dest#"$HOME"}"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "link    $dest -> $src"
}

link config/alacritty "$HOME/.config/alacritty"
link config/tmux      "$HOME/.config/tmux"
link config/nvim      "$HOME/.config/nvim"
link local/bin/dev    "$HOME/.local/bin/dev"

# zsh: source our block from ~/.zshrc (don't symlink the whole file — it holds
# oh-my-zsh / p10k / machine-specific lines we don't manage here).
if ! grep -qF 'dotfiles/zsh/piidesk-ide.zsh' "$HOME/.zshrc" 2>/dev/null; then
  {
    printf '\n# piidesk dev environment (managed by ~/.dotfiles)\n'
    printf '[ -f "$HOME/.dotfiles/zsh/piidesk-ide.zsh" ] && source "$HOME/.dotfiles/zsh/piidesk-ide.zsh"\n'
  } >> "$HOME/.zshrc"
  echo "zshrc   appended source line"
else
  echo "ok      ~/.zshrc already sources piidesk-ide.zsh"
fi

echo
echo "Done.${BACKUP:+  Backups (if any) in $BACKUP}"
echo "Open a new shell (or: source ~/.zshrc) to pick up the zsh changes."
