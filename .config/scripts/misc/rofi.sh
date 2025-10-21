#!/usr/bin/env bash

SCRIPTS_DIR="${HOME}/.config/scripts"
TERMINAL="kitty"

SCRIPTS=(
    "New wallpaper"
    "VPN"
    "YT download"
    "Random"
    "Images"
    "Notes"
)

script=$(printf "%s\n" "${SCRIPTS[@]}" | \
    sort | \
    rofi -dmenu \
    -p "Script:" \
    -i \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: $(printf "%s\n" "${SCRIPTS[@]}" | wc -l); }"
)

[[ -z "${script}" ]] && exit 0

case "${script}" in
    "New wallpaper") ${SCRIPTS_DIR}/wallpapers/new_wallpaper.sh & ;;
    "VPN") ${SCRIPTS_DIR}/misc/vpn.sh & ;;
    "YT download") ${SCRIPTS_DIR}/misc/yt.sh & ;;
    "Random") ${SCRIPTS_DIR}/misc/random.sh & ;;
    "Images") ${TERMINAL} -T "images" -e ${SCRIPTS_DIR}/misc/images.sh & ;;
    "Notes") ${SCRIPTS_DIR}/notes/obsidian.sh & ;;
esac

