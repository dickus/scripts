#!/usr/bin/env bash

SCRIPTS_DIR="${HOME}/.config/scripts"
TERMINAL="kitty"
CLIPBOARD=$(wl-paste)

SCRIPTS=(
    "VPN"
    "Random"
    "Images"
    "Notes"
    "Download"
)

script=$(
    printf "%s\n" "${SCRIPTS[@]}" | \
    sort | \
    rofi -dmenu \
        -p "Script:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: $( \
            printf "%s\n" "${SCRIPTS[@]}" | \
            wc -l
        ); }"
)

[[ -z "${script}" ]] && exit 0

case "${script}" in
    "VPN") ${SCRIPTS_DIR}/misc/vpn.sh & ;;
    "Random") ${SCRIPTS_DIR}/misc/random.sh & ;;
    "Images") ${TERMINAL} -T "images" -e ${SCRIPTS_DIR}/misc/images.sh & ;;
    "Notes") ${SCRIPTS_DIR}/notes/obsidian.sh & ;;
    "Download") ${SCRIPTS_DIR}/misc/download.sh & ;;
esac

