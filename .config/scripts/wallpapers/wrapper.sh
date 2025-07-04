#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"

INTERVAL=600

while true; do
    CURRENT_HOUR=$(date +%H)
    CURRENT_MINUTE=$(date +%M)
    TOTAL_MINUTES=$((10#$CURRENT_HOUR * 60 + 10#$CURRENT_MINUTE))

    if (( TOTAL_MINUTES >= 480 && TOTAL_MINUTES < 1170 )); then
        MODE="light"
    else
        MODE="dark"
    fi

    find "$WALLPAPER_DIR/$MODE" \
    | while read -r img; do
        echo "$((RANDOM % 1000)):$img"
    done \
    | sort -n | cut -d':' -f2- \
    | while read -r img; do
        if [[ "$img" != "$WALLPAPER_DIR/$MODE" ]]; then
            $HOME/.config/scripts/wallpapers/wayland_wallpaper.sh "$img" "$new_wall"

            sleep $INTERVAL
        fi
    done
done

