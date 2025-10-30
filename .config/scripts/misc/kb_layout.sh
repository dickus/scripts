#!/usr/bin/env bash

keyboards_json=$(
    hyprctl devices -j | \
    jq '.keyboards'
)

main_keyboard=$(
    echo "${keyboards_json}" | \
    jq '.[] | select(.main == true)'
)

if [[ "${main_keyboard}" == "null" ]] || [[ -z "${main_keyboard}" ]]; then
    current_layout=$(
        echo "${keyboards_json}" | \
        jq -r '.[0].active_keymap // "Unknown"'
    )
else
    current_layout=$(
        echo "${main_keyboard}" | \
        jq -r '.active_keymap // "Unknown"'
    )
fi

notify-send -t 800 "Keyboard" "${current_layout}"

