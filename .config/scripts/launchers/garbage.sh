#!/usr/bin/env bash

garbage=(
    "Yandex Browser"
    "Zoom"
)

app=$(printf "%s\n" "${garbage[@]}" | \
    sort | \
    rofi -dmenu \
    -p "Apps:" \
    -i \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 2; }"
)

[[ -z "${app}" ]] && exit 0

case "${app}" in
    "Yandex Browser")
        ru.yandex.Browser & ;;
    "Zoom")
        ${HOME}/.config/scripts/run/zoom.sh & ;;
esac

