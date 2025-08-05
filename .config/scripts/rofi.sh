#!/bin/bash

SCRIPTS_DIR="$HOME/.config/scripts"

script=$(echo -e "New wallpaper\nVPN\nYouTube download" | rofi -dmenu \
    -p "Script:" \
    -i \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 3; }"
)

[[ -z "${script}" ]] && exit 0

if [[ "${script}" == "New wallpaper" ]]; then
    ${SCRIPTS_DIR}/system/new_wallpaper.sh
elif [[ "${script}" == "VPN" ]]; then
    ${SCRIPTS_DIR}/system/vpn.sh
elif [[ "${script}" == "YouTube download" ]]; then
    ${SCRIPTS_DIR}/system/yt.sh
fi

