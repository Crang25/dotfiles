#!/usr/bin/env bash
if [ "$(nmcli radio wifi)" = "enabled" ]; then
    conn=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    [ -n "$conn" ] && echo "  $conn" || echo "󱛇  Scanning..."
else
    echo "󰖪 WiFi Off"
fi
