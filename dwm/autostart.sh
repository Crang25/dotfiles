#!/usr/bin/env bash

set -euo pipefail

pkill -x sxhkd 2>/dev/null || true
sxhkd -c "$HOME/.config/sxhkd/sxhkdrc.dwm" &

pkill -f "$HOME/.config/dwm/status.sh" 2>/dev/null || true
bash "$HOME/.config/dwm/status.sh" &

pgrep -x picom >/dev/null || picom --config "$HOME/.config/picom/picom.conf" &
pgrep -x dunst >/dev/null || dunst &
pgrep -x nm-applet >/dev/null || nm-applet &
pgrep -x blueman-applet >/dev/null || blueman-applet &

if command -v systemctl >/dev/null 2>&1; then
	systemctl --user start redshift.service >/dev/null 2>&1 || (redshift -x && redshift -O 4700 &)
else
	redshift -x && redshift -O 4700 &
fi

feh --bg-fill "$HOME/Pictures/wallpapers/gruvbox/school_of_athens.jpg"
xsetroot -cursor_name left_ptr

if [ -f "$HOME/.Xresources" ]; then
	xrdb -merge "$HOME/.Xresources"
fi
