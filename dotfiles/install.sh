#!/usr/bin/env bash
# install.sh — symlink this repo's dotfiles into place.
#
# Idempotent and safe: re-running does nothing if links are already correct,
# and anything it would overwrite is moved to a timestamped backup first.
#
#   ~/Development/dotfiles/config/alacritty  ->  ~/.config/alacritty
#   ~/Development/dotfiles/config/tmux       ->  ~/.config/tmux
#   ~/Development/dotfiles/config/nvim       ->  ~/.config/nvim
#   ~/Development/dotfiles/local/bin/ide     ->  ~/.local/bin/ide
#   ~/.zshrc  gets a `source` line for  ~/Development/dotfiles/zsh/ide.zsh
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
link local/bin/ide    "$HOME/.local/bin/ide"

# zsh: source our block from ~/.zshrc (don't symlink the whole file — it holds
# oh-my-zsh / p10k / machine-specific lines we don't manage here).
if ! grep -qF 'Development/dotfiles/zsh/ide.zsh' "$HOME/.zshrc" 2>/dev/null; then
  {
    printf '\n# terminal IDE environment (managed by ~/Development/dotfiles)\n'
    printf '[ -f "$HOME/Development/dotfiles/zsh/ide.zsh" ] && source "$HOME/Development/dotfiles/zsh/ide.zsh"\n'
  } >> "$HOME/.zshrc"
  echo "zshrc   appended source line"
else
  echo "ok      ~/.zshrc already sources ide.zsh"
fi

echo
echo "Done.${BACKUP:+  Backups (if any) in $BACKUP}"
echo "Open a new shell (or: source ~/.zshrc) to pick up the zsh changes."
