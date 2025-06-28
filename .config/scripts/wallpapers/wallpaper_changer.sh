#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"

CURRENT_HOUR=$(date +%H)
CURRENT_MINUTE=$(date +%M)
TOTAL_MINUTES=$((10#$CURRENT_HOUR * 60 + 10#$CURRENT_MINUTE))

if (( TOTAL_MINUTES >= 480 && TOTAL_MINUTES < 1170 )); then
    MODE="light"
else
    MODE="dark"
fi

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export SWWW_TRANSITION_FPS=60
    export SWWW_TRANSITION_STEP=2
    export SWWW_TRANSITION_TYPE=simple

    mapfile -d '' files < <(find "$WALLPAPER_DIR/$MODE" -type f -print0)

    random_img=$(( RANDOM % ${#files[@]} ))

    swww img "${files[$random_img]}"

    sed -i "s|/wallpapers/.*|${files[$random_img]#*Pictures}|" $HOME/.config/hypr/hyprlock.conf
else
    export DISPLAY=:0.0

    feh --bg-fill --randomize $WALLPAPER_DIR/$MODE
fi

