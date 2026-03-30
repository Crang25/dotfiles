# Dotfiles

Personal Linux dotfiles for terminal tools, editors, and an X11 desktop setup built around `bspwm` with an in-progress `dwm` migration scaffold.

## What this repo includes

- Shell and terminal: `zsh`, `kitty`, `tmux`, `yazi`
- Editor configs: `nvim`, `emacs`
- System tools: `btop`, `fastfetch`, `wallust`, `swappy`
- `bspwm` stack: `bspwm`, `sxhkd`, `picom`, `polybar`, `dunst`, `rofi`
- `dwm` starter config, session startup, and NixOS package wiring
- Optional NixOS configs: `nixos/`

## Quick install

The install script creates symlinks from this repo to your `~/.config` (and `~/.zshrc`, `~/.tmux.conf`).

1. Clone this repo wherever you keep it, then enter the repo:

```bash
git clone <your-repo-url> ~/projects/dotfiles
cd ~/projects/dotfiles
```

2. Run the installer:

```bash
chmod +x install.sh
./install.sh
```

## Notes

- `install.sh` auto-detects the repo path from the script location.
- Existing non-symlink targets are backed up with a timestamp suffix before linking.
- NixOS files are not symlinked by default. Copy them manually if needed:

```bash
sudo cp ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
sudo cp ~/dotfiles/nixos/flake.nix /etc/nixos/flake.nix
sudo cp ~/dotfiles/nixos/home.nix /etc/nixos/home.nix
```

## Suggested packages

- `lsd` (colorful `ls` replacement with icons)
- `ags`
- `btop`
- `fastfetch`
