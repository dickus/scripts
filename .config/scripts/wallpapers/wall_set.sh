#!/usr/bin/env bash

wall=$(echo "${1}" | sed 's|.*/Pictures/||')

swww img "${1}" --transition-type center

sed -i "s|wallpapers/.*|${wall}|" ${HOME}/.config/hypr/hyprlock.conf

