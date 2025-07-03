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

export DISPLAY=:0.0

feh --bg-fill --randomize $WALLPAPER_DIR/$MODE

