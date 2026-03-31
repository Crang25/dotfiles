#!/usr/bin/env bash

set -euo pipefail

choice="$(
	printf '%s\n' "Suspend" "Reboot" "Shutdown" "Logout" | \
	rofi -dmenu -i -no-custom \
		-p "Power" \
		-theme "$HOME/.config/rofi/gruvbox.rasi"
)"

logout_session() {
	if [ -n "${XDG_SESSION_ID:-}" ]; then
		loginctl terminate-session "$XDG_SESSION_ID"
	else
		pkill -x dwm
	fi
}

case "$choice" in
	"Suspend")
		systemctl suspend
		;;
	"Reboot")
		systemctl reboot
		;;
	"Shutdown")
		systemctl poweroff
		;;
	"Logout")
		logout_session
		;;
	*)
		exit 0
		;;
esac
