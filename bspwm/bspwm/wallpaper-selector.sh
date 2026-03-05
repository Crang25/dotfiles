#!/bin/sh

# Wallpaper directories
WALLPAPER_DIRS=(
    "$HOME/Pictures/wallpapers"
    # "$HOME/Pictures/Wallpapers/Urban"
)

# Collect all wallpapers
WALLPAPERS=()
for dir in "${WALLPAPER_DIRS[@]}"; do
    while IFS= read -r -d '' file; do
        WALLPAPERS+=("$file")
    done < <(find "$dir" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) -print0)
done

# Select wallpaper using Rofi
SELECTED=$(printf '%s\n' "${WALLPAPERS[@]}" | rofi -dmenu -theme gruvbox-dark -i -p "Select Wallpaper:" -theme-str 'window {width: 80%; height: 80%;}')

# Check if a wallpaper was selected
if [ -n "$SELECTED" ]; then
    # Set wallpaper with feh
    feh --bg-fill "$SELECTED"
    
    # Optional: Notification
    notify-send "Wallpaper Changed" "New wallpaper set: $(basename "$SELECTED")"
fi


# Select wallpaper with preview
# SELECTED=$(printf '%s\n' "${WALLPAPERS[@]}" | rofi \
#     -show wallpapers \
#     -modi "wallpapers:~/.config/bspwm/wallpaper-preview.sh" \
#     -theme-str 'window {width: 80%; height: 80%;}' \
#     -p "Select Wallpaper:")

