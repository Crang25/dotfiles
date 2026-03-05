#!/bin/sh

# Preview script for Rofi
while read -r file; do
    # Generate thumbnail (optional)
    convert "$file" -resize 300x300^ -gravity center -extent 300x300 "/tmp/wallpaper_thumb_$(basename "$file").png"
    echo -e "$file\0icon\x1f/tmp/wallpaper_thumb_$(basename "$file").png"
done
