#!/usr/bin/env bash

wl-copy --clear

hyprpicker -a -f hex -r

if [[ "$(wl-paste)" ]]; then
    notify-send -t 2000 "Color picked" "$(wl-paste)"
fi

