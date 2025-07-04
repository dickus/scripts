#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
img=$1

swww img "$img"

new_wall=$(echo $img | sed "s|.*/wallpapers|wallpapers|")

sed -i "s|wallpapers/.*|$new_wall|" $HOME/.config/hypr/hyprlock.conf

