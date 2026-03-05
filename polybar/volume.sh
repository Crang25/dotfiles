#!/usr/bin/env bash

VOLUME=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$MUTED" = "true" ]; then
  echo " | 󰖁  Muted"
else
  # Progress bar using Unicode blocks
  BAR=$(seq -s "─" 0 $((VOLUME/5)) | sed 's/[0-9]//g')
  echo " |   Volume: $VOLUME%"
  # if you would like to see volume bar use belove line instead above one
  # echo "Volume: $VOLUME% $BAR "
fi
