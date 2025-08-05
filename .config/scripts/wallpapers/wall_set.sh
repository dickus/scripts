#!/bin/bash

wall=$(echo "${1}" | sed 's|.*/Pictures/||')

swww img "${1}"

sed -i "s|wallpapers/.*|${wall}|" $HOME/.config/hypr/hyprlock.conf

