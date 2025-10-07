#!/usr/bin/env bash

number=$(rofi -dmenu \
    -p "Integer:" \
    -theme-str "window { width: 15%; }" \
    -theme-str "listview { lines: 1; }" \
)

if ! [[ ${number} =~ ^[1-9][0-9]*$ ]]; then
    dunstify -t 5000 "Are you retarded or something?"

    exit 0
fi

RANDOM_NUMBER=$((1 + RANDOM % ${number}))

dunstify -t 5000 "${RANDOM_NUMBER}"

