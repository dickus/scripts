#!/bin/bash

DESIRED_THEME=""

CURRENT_TIME=$(date +%-H%M)
EVENING_TIME=1930
MORNING_TIME=800

THEME_SCRIPT="$HOME/.config/scripts/theme_change/theme_schedule.sh"


if (( 10#$CURRENT_TIME >= 1930 || 10#$CURRENT_TIME < 800 )); then
    DESIRED_THEME="dark"

    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        hyprctl hyprsunset temperature 5000
    fi
else
    DESIRED_THEME="light"

    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        hyprctl hyprsunset temperature reload
    fi
fi

$THEME_SCRIPT $DESIRED_THEME

