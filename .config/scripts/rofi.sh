#!/bin/bash

SCRIPTS_DIR="$HOME/.config/scripts/rofi_scripts"
TERMINAL="kitty"

script=$(echo -e "Wallpaper\nNote\nVPN\nYouTube" | rofi -dmenu \
    -p "Script:" \
    -theme-str "window { width: 15%; }" \
    -theme-str "listview { lines: 5; }"
)

case $script in
    Wallpaper)
        ${SCRIPTS_DIR}/new_wallpaper.sh ;;
    Note)
        ${SCRIPTS_DIR}/new_note.sh ${TERMINAL};;
    VPN)
        ${SCRIPTS_DIR}/vpn.sh ;;
    YouTube)
        ${SCRIPTS_DIR}/yt.sh ;;
esac

