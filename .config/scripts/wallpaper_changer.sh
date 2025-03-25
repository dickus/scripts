#!/bin/bash

export DISPLAY=:0.0

current_hour=$(date +%H)
current_minute=$(date +%M)
total_minutes=$((10#$current_hour * 60 + 10#$current_minute))

if (( total_minutes >= 480 && total_minutes < 1170 )); then
    mode="light"
else
    mode="dark"
fi

feh --bg-fill --randomize ~/Pictures/wallpapers/$mode

