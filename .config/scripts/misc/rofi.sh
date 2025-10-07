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
    "New wallpaper") ${SCRIPTS_DIR}/wallpapers/new_wallpaper.sh ;;
    "VPN") ${SCRIPTS_DIR}/misc/vpn.sh ;;
    "YouTube download") ${SCRIPTS_DIR}/misc/yt.sh ;;
    "Random") ${SCRIPTS_DIR}/misc/random.sh ;;
esac

