#!/usr/bin/env bash
# install.sh — symlink this repo's dotfiles into place.
#
# Idempotent and safe: re-running does nothing if links are already correct,
# and anything it would overwrite is moved to a timestamped backup first.
#
#   ~/Development/dotfiles/config/tmux       ->  ~/.config/tmux
#   ~/Development/dotfiles/config/nvim       ->  ~/.config/nvim
#   ~/Development/dotfiles/config/ghostty    ->  ~/.config/ghostty
#   ~/Development/dotfiles/config/git        ->  ~/.config/git
#   ~/Development/dotfiles/config/starship.toml -> ~/.config/starship.toml
#   ~/Development/dotfiles/local/bin/ide     ->  ~/.local/bin/ide
#   ~/Development/dotfiles/zsh/zprofile      ->  ~/.zprofile
#   ~/Development/dotfiles/git/gitconfig     ->  ~/.gitconfig
#   ~/.zshrc  gets a `source` line for  ~/Development/dotfiles/zsh/zshrc.zsh
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

link config/tmux      "$HOME/.config/tmux"
link config/nvim      "$HOME/.config/nvim"
link config/ghostty       "$HOME/.config/ghostty"
link config/git           "$HOME/.config/git"
link config/starship.toml "$HOME/.config/starship.toml"
link local/bin/ide        "$HOME/.local/bin/ide"
link zsh/zprofile         "$HOME/.zprofile"
link git/gitconfig        "$HOME/.gitconfig"

# zsh: keep a thin ~/.zshrc that sources our managed rc. We don't symlink the
# whole file — it holds machine-specific lines (custom PATH exports) we don't
# commit. zshrc.zsh in turn sources ide.zsh, so we no longer append that here.
if ! grep -qF 'Development/dotfiles/zsh/zshrc.zsh' "$HOME/.zshrc" 2>/dev/null; then
  {
    printf '\n# managed shell config (~/Development/dotfiles)\n'
    printf 'source "$HOME/Development/dotfiles/zsh/zshrc.zsh"\n'
  } >> "$HOME/.zshrc"
  echo "zshrc   appended source line for zshrc.zsh"
else
  echo "ok      ~/.zshrc already sources zshrc.zsh"
fi

echo
echo "Done.${BACKUP:+  Backups (if any) in $BACKUP}"
echo "Open a new shell (or: source ~/.zshrc) to pick up the zsh changes."
