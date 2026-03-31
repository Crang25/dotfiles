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

update_cpu_status() {
	local cpu user nice system idle iowait irq softirq steal guest guest_nice
	local idle_total total total_delta idle_delta usage

	if ! read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat; then
		cpu_text="CPU n/a"
		return
	fi

	idle_total=$((idle + iowait))
	total=$((user + nice + system + idle + iowait + irq + softirq + steal))

	if [ -n "$prev_cpu_total" ] && [ "$total" -gt "$prev_cpu_total" ]; then
		total_delta=$((total - prev_cpu_total))
		idle_delta=$((idle_total - prev_cpu_idle))
		usage=$(((100 * (total_delta - idle_delta)) / total_delta))
		cpu_text="CPU ${usage}%"
	else
		cpu_text="CPU n/a"
	fi

	prev_cpu_total=$total
	prev_cpu_idle=$idle_total
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

update_cpu_status
while true; do
	update_cpu_status
	xsetroot -name "$(wifi_status) | $(volume_status) | $(mic_status) | $(brightness_status) | ${cpu_text} | $(memory_status) | $(battery_status) | $(clock_status)"
	sleep "$interval"
done
