#!/usr/bin/env bash

wl-copy --clear

hyprpicker -a -f hex -r

if [[ "$(wl-paste)" ]]; then
    dunstify -t 5000 "Color picked" "$(wl-paste)"
fi

