#!/bin/bash

# Create symbolic links
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/kitty ~/.config/kitty
ln -sf ~/dotfiles/yazi ~/.config/yazi
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

ln -sf ~/dotfiles/wallust ~/.config/wallust
ln -sf ~/dotfiles/swappy ~/.config/swappy
ln -sf ~/dotfiles/btop ~/.config/btop
ln -sf ~/dotfiles/fastfetch ~/.config/fastfetch

# bspwm desktop environment
ln -sf ~/dotfiles/bspwm ~/.config/bspwm
ln -sf ~/dotfiles/sxhkd ~/.config/sxhkd
ln -sf ~/dotfiles/picom ~/.config/picom
ln -sf ~/dotfiles/polybar ~/.config/polybar
ln -sf ~/dotfiles/dunst ~/.config/dunst
ln -sf ~/dotfiles/rofi ~/.config/rofi

# editors
ln -sf ~/dotfiles/emacs ~/.config/emacs

# nixos (copy, not symlink - requires sudo)
# sudo cp ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
# sudo cp ~/dotfiles/nixos/flake.nix /etc/nixos/flake.nix
# sudo cp ~/dotfiles/nixos/home.nix /etc/nixos/home.nix

echo "Dotfiles installed successfully!"
