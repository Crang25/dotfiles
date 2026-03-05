#!/usr/bin/env bash

# Get list of available WiFi networks
list_wifi() {
    nmcli --fields "SECURITY,SSID" device wifi list | \
    awk -F'  +' '{if ($1 == "--") printf "  %s\n", $2; else printf "  %s\n", $2}' | \
    sort -u
}

# Connect to selected network
connect() {
    selected=$(list_wifi | rofi -dmenu -p "WiFi" -theme-str 'window {width: 30%;}')
    if [ -z "$selected" ]; then exit; fi

    ssid=$(echo "$selected" | sed 's/^.*  //')
    if nmcli -g NAME connection show | grep -q "^${ssid}$"; then
        nmcli connection up "$ssid"
    else
        pass=$(rofi -dmenu -p "Password" -password -theme-str 'window {width: 20%;}')
        [ -n "$pass" ] && nmcli device wifi connect "$ssid" password "$pass"
    fi
}

# Toggle WiFi
toggle() {
    if [ "$(nmcli radio wifi)" = "enabled" ]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
        sleep 2  # Wait for scan
        connect
    fi
}

case "$1" in
    --toggle) toggle ;;
    *) connect ;;
esac
