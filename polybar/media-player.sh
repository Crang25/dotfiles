#!/bin/sh

# status=$(playerctl status 2>/dev/null)
# if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
#   artist=$(playerctl metadata artist)
#   title=$(playerctl metadata title)
#   echo "♫ $artist - $title ($status) | "
# else
#   echo ""
# fi


# Configuration
MAX_LENGTH=30  # Adjust this to fit your polybar width
ELLIPSIS="..."

status=$(playerctl status 2>/dev/null)
if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
  artist=$(playerctl metadata artist)
  title=$(playerctl metadata title)
  
  # Function to truncate text
  truncate() {
    local str="$1"
    if [ ${#str} -gt $MAX_LENGTH ]; then
      echo "${str:0:$((MAX_LENGTH-3))}$ELLIPSIS"
    else
      echo "$str"
    fi
  }

  # Truncate both artist and title
  artist_trunc=$(truncate "$artist")
  title_trunc=$(truncate "$title")
  
  echo "  $status: $artist_trunc - $title_trunc | "
else
  echo "  Not playing "
fi
