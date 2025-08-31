#!/usr/bin/env bash

SCRIPTS_DIR="${HOME}/.config/scripts"

script=$(echo -e "New wallpaper\nVPN\nYouTube download\nRandom" | \
    sort | \
    rofi -dmenu \
    -p "Script:" \
    -i \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 4; }"
)

[[ -z "${script}" ]] && exit 0

case "${script}" in
    "New wallpaper") ${SCRIPTS_DIR}/system/new_wallpaper.sh ;;
    "VPN") ${SCRIPTS_DIR}/system/vpn.sh ;;
    "YouTube download") ${SCRIPTS_DIR}/system/yt.sh ;;
    "Random") ${SCRIPTS_DIR}/random.sh ;;
esac

