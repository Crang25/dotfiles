#!/bin/sh

# Check if traybar is already running
if pgrep -x "polybar" | grep -q "traybar"; then
    pkill -f "polybar traybar"  # Close it
else
    polybar traybar &  # Launch tray bar
fi
