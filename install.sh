#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

backup_target() {
  local target="$1"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$target" "$backup"
    echo "Backed up $target to $backup"
  fi
}

link_path() {
  local source_path="$1"
  local target_path="$2"

  backup_target "$target_path"
  ln -sfn "$source_path" "$target_path"
}

mkdir -p "$HOME/.config"

link_path "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_path "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_path "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"
link_path "$DOTFILES_DIR/yazi" "$HOME/.config/yazi"
link_path "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

link_path "$DOTFILES_DIR/wallust" "$HOME/.config/wallust"
link_path "$DOTFILES_DIR/swappy" "$HOME/.config/swappy"
link_path "$DOTFILES_DIR/btop" "$HOME/.config/btop"
link_path "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"

# X11 desktop environment
link_path "$DOTFILES_DIR/bspwm" "$HOME/.config/bspwm"
link_path "$DOTFILES_DIR/dwm" "$HOME/.config/dwm"
link_path "$DOTFILES_DIR/sxhkd" "$HOME/.config/sxhkd"
link_path "$DOTFILES_DIR/picom" "$HOME/.config/picom"
link_path "$DOTFILES_DIR/polybar" "$HOME/.config/polybar"
link_path "$DOTFILES_DIR/dunst" "$HOME/.config/dunst"
link_path "$DOTFILES_DIR/rofi" "$HOME/.config/rofi"

# editors
link_path "$DOTFILES_DIR/emacs" "$HOME/.config/emacs"

# nixos (copy, not symlink - requires sudo)
# sudo cp "$DOTFILES_DIR/nixos/configuration.nix" /etc/nixos/configuration.nix
# sudo cp "$DOTFILES_DIR/nixos/flake.nix" /etc/nixos/flake.nix
# sudo cp "$DOTFILES_DIR/nixos/home.nix" /etc/nixos/home.nix

echo "Dotfiles installed successfully from $DOTFILES_DIR"
