# Desktop Cheat Sheet

`MOD` = `Super`

## DWM Window Management

- `MOD + j`: focus next window
- `MOD + k`: focus previous window
- `MOD + Shift + Return`: promote focused window to master
- `MOD + q`: close focused window
- `MOD + s`: toggle floating for focused window

## DWM Layout Management

- `MOD + t`: tile layout
- `MOD + f`: monocle layout
- `MOD + Shift + Space`: switch to previous/alternate layout
- `MOD + h`: shrink master area
- `MOD + l`: grow master area

## DWM Tag Management

- `MOD + 1..9`: view tag
- `MOD + Tab`: return to previous tag/view
- `MOD + 0`: view all tags
- `MOD + Shift + 1..9`: move focused window to tag
- `MOD + Shift + 0`: show focused window on all tags
- `MOD + Ctrl + 1..9`: toggle tag in current view
- `MOD + Ctrl + Shift + 1..9`: toggle focused window on tag

## DWM Multi-Monitor

- `MOD + ,`: focus previous monitor
- `MOD + .`: focus next monitor
- `MOD + Shift + ,`: move focused window to previous monitor
- `MOD + Shift + .`: move focused window to next monitor

## DWM Session

- `MOD + Ctrl + q`: quit `dwm`

## SXHKD Launchers

- `MOD + Return`: open `kitty`
- `MOD + d`: open `rofi`
- `MOD + m`: open `dmenu_run`
- `MOD + Shift + f`: open `thunar`
- `Alt + g`: open `google-chrome-stable`
- `MOD + n`: open `nmtui` in `kitty`
- `MOD + Shift + s`: open `flameshot`
- `MOD + w`: wallpaper selector
- `MOD + Shift + n`: notification menu
- `MOD + Shift + p`: power menu
- `MOD + Escape`: reload `sxhkd`

## SXHKD Media And System

- `XF86AudioRaiseVolume`: volume up
- `XF86AudioLowerVolume`: volume down
- `XF86AudioMute`: toggle output mute
- `MOD + F1`: toggle mic mute
- `MOD + F2`: mic volume up
- `MOD + F3`: mic volume down
- `XF86MonBrightnessUp`: brightness up
- `XF86MonBrightnessDown`: brightness down
- `MOD + Space`: toggle keyboard layout between `us` and `ru`

## Polybar Mouse Actions

- `date`: left click opens `calcurse`
- `media`: left click play/pause, middle click stop, right click next track
- `media`: scroll up/down changes player volume
- `wifi`: left click opens `nmtui` in `kitty`
- `volume`: left click toggles mute, right click opens `pavucontrol`
- `volume`: scroll up/down changes output volume
- `mic`: left click toggles source mute, right click opens `pavucontrol` on input tab

## Bar Items

- `date`: date and time
- `media`: current player state/title
- `cpu`: CPU usage
- `ram`: memory usage
- `wifi`: current Wi-Fi SSID or disconnected state
- `volume`: output volume state
- `mic`: microphone mute/level state
- `brightness`: current backlight level
- `battery`: charge state and percentage
- `tray`: system tray icons

## Useful Workflows

- Move a window to another tag: `MOD + Shift + 3`, then `MOD + 3`
- Show multiple tags at once: `MOD + Ctrl + 2`, then `MOD + Ctrl + 3`
- Keep one window on multiple tags: `MOD + Ctrl + Shift + 2`
- Focus a distraction-free single window: `MOD + f`
- Open the power menu without a terminal: `MOD + Shift + p`
- Change Wi-Fi from the bar or keyboard: click `wifi` in `polybar` or press `MOD + n`
