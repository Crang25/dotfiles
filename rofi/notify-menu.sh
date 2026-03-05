#!/bin/sh

# dunstctl history | \
#   jq -r '.data[] | "\(.appname): \(.summary)\n\(.body)"' | \  rofi -dmenu -p "Notifications" -theme gruvbox-dark


# Get notifications in reverse chronological order
notifications=$(dunstctl history | \
  jq -r '.data[][] | select(.appname.data != "dunst") | "\(.appname.data): \(.summary.data)\n\(.body.data)"' | tac)


# Show in Rofi with proper line handling
echo -e "$notifications" | rofi \
  -dmenu \
  -p "󰂚 Notifications" \
  -theme gruvbox-dark \
  -kb-custom-1 "Control+Shift+d" \
  -mesg "Ctrl+d to clear all" \
  -markup-rows

# Clear notifications if Ctrl+d was pressed
if [ $? -eq 10 ]; then
  dunstctl close-all
  dunstctl history-pop
fi


# dunstctl history | \
#   jq -r '.data[][] | select(.appname.data != "dunst") | "\(.appname.data): \(.summary.data)\n\(.body.data)"' | \
#   rofi -dmenu -p "Notifications" -theme gruvbox-dark -lines 5

