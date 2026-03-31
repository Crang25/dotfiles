#!/usr/bin/env bash

set -euo pipefail

interval="${1:-5}"

wifi_status() {
	if [ "$(nmcli radio wifi 2>/dev/null)" = "enabled" ]; then
		local ssid
		ssid="$(nmcli -t -f active,ssid dev wifi | awk -F: '$1 == "yes" { print $2; exit }')"
		if [ -n "$ssid" ]; then
			printf "WiFi %s" "$ssid"
		else
			printf "WiFi scanning"
		fi
	else
		printf "WiFi off"
	fi
}

volume_status() {
	if [ "$(pamixer --get-mute 2>/dev/null || printf true)" = "true" ]; then
		printf "Vol muted"
	else
		printf "Vol %s%%" "$(pamixer --get-volume 2>/dev/null || printf '?')"
	fi
}

brightness_status() {
	local percent
	percent="$(brightnessctl info 2>/dev/null | sed -n 's/.*(\([0-9]\+%\)).*/\1/p' | head -n 1)"
	if [ -n "$percent" ]; then
		printf "Bri %s" "$percent"
	else
		printf "Bri n/a"
	fi
}

mic_status() {
	if [ "$(pamixer --default-source --get-mute 2>/dev/null || printf true)" = "true" ]; then
		printf "Mic muted"
	else
		printf "Mic %s%%" "$(pamixer --default-source --get-volume 2>/dev/null || printf '?')"
	fi
}

memory_status() {
	free | awk '/Mem:/ {printf "RAM %.0f%%", ($3 / $2) * 100}'
}

battery_status() {
	local battery_line
	battery_line="$(acpi -b 2>/dev/null | head -n 1 || true)"
	if [ -n "$battery_line" ]; then
		printf "%s" "$battery_line" | awk -F', ' '{printf "Bat %s", $2}'
	else
		printf "Bat n/a"
	fi
}

clock_status() {
	date '+%a %d-%m-%Y %H:%M'
}

while true; do
	xsetroot -name "$(wifi_status) | $(volume_status) | $(mic_status) | $(brightness_status) | $(memory_status) | $(battery_status) | $(clock_status)"
	sleep "$interval"
done
