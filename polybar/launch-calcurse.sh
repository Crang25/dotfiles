#!/usr/bin/env bash

# Check if calcurse is installed
if ! command -v calcurse &> /dev/null; then
  notify-send "Calcurse Error" "calcurse is not installed"
  exit 1
fi

# Launch calcurse in new Kitty window
kitty --title "Calcurse" --hold calcurse
