#!/usr/bin/env bash

set -euo pipefail

interval="${1:-5}"
prev_cpu_total=""
prev_cpu_idle=""

wifi_status() {
	if [ "$(nmcli radio wifi 2>/dev/null)" = "enabled" ]; then
		local ssid
		ssid="$(nmcli -t -f active,ssid dev wifi | awk -F: '$1 == "yes" { print $2; exit }')"
		if [ -n "$ssid" ]; then
			printf " %s" "$ssid"
		else
			printf " scanning"
		fi
	else
		printf " off"
	fi
}

volume_status() {
	if [ "$(pamixer --get-mute 2>/dev/null || printf true)" = "true" ]; then
		printf "󰖁 muted"
	else
		printf " %s%%" "$(pamixer --get-volume 2>/dev/null || printf '?')"
	fi
}

brightness_status() {
	local percent
	percent="$(brightnessctl info 2>/dev/null | sed -n 's/.*(\([0-9]\+%\)).*/\1/p' | head -n 1)"
	if [ -n "$percent" ]; then
		printf "󰃠 %s" "$percent"
	else
		printf "󰃠 n/a"
	fi
}

mic_status() {
	if [ "$(pamixer --default-source --get-mute 2>/dev/null || printf true)" = "true" ]; then
		printf "󰍭 muted"
	else
		printf "󰍬 %s%%" "$(pamixer --default-source --get-volume 2>/dev/null || printf '?')"
	fi
}

update_cpu_status() {
	local cpu user nice system idle iowait irq softirq steal guest guest_nice
	local idle_total total total_delta idle_delta usage

	if ! read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat; then
		cpu_text=" n/a"
		return
	fi

	idle_total=$((idle + iowait))
	total=$((user + nice + system + idle + iowait + irq + softirq + steal))

	if [ -n "$prev_cpu_total" ] && [ "$total" -gt "$prev_cpu_total" ]; then
		total_delta=$((total - prev_cpu_total))
		idle_delta=$((idle_total - prev_cpu_idle))
		usage=$(((100 * (total_delta - idle_delta)) / total_delta))
		cpu_text=" ${usage}%"
	else
		cpu_text=" n/a"
	fi

	prev_cpu_total=$total
	prev_cpu_idle=$idle_total
}

memory_status() {
	free | awk '/Mem:/ {printf " %.0f%%", ($3 / $2) * 100}'
}

battery_status() {
	local battery_line percent icon
	battery_line="$(acpi -b 2>/dev/null | head -n 1 || true)"
	if [ -n "$battery_line" ]; then
		percent="$(printf "%s" "$battery_line" | sed -n 's/.* \([0-9]\+%\).*/\1/p')"
		case "${percent%\%}" in
			9|[0-9]) icon="" ;;
			1[0-9]|2[0-4]) icon="" ;;
			2[5-9]|3[0-9]|4[0-9]) icon="" ;;
			5[0-9]|6[0-9]|7[0-4]) icon="" ;;
			*) icon="" ;;
		esac
		if printf "%s" "$battery_line" | grep -q "Charging"; then
			icon=" ${icon}"
		fi
		if [ -n "$percent" ]; then
			printf "%s %s" "$icon" "$percent"
		else
			printf "%s n/a" "$icon"
		fi
	else
		printf " n/a"
	fi
}

clock_status() {
	date '+ %a %d-%m-%Y  %H:%M'
}

update_cpu_status
while true; do
	update_cpu_status
	xsetroot -name "$(clock_status) | $(wifi_status) | $(volume_status) | $(mic_status) | $(brightness_status) | ${cpu_text} | $(memory_status) | $(battery_status)"
	sleep "$interval"
done
