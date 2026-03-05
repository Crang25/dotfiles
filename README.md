# Dotfiles

Personal Linux dotfiles for terminal tools, editors, and a `bspwm` desktop setup.

## What this repo includes

- Shell and terminal: `zsh`, `kitty`, `tmux`, `yazi`
- Editor configs: `nvim`, `emacs`
- System tools: `btop`, `fastfetch`, `wallust`, `swappy`
- `bspwm` stack: `bspwm`, `sxhkd`, `picom`, `polybar`, `dunst`, `rofi`
- Optional NixOS configs: `nixos/`

## Quick install

The install script creates symlinks from this repo to your `~/.config` (and `~/.zshrc`, `~/.tmux.conf`).

1. Clone this repo to `~/dotfiles`:

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

2. Run the installer:

```bash
chmod +x install.sh
./install.sh
```

## Notes

- `install.sh` uses `ln -sf`, so existing target files can be replaced.
- The script expects this path: `~/dotfiles`.
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

