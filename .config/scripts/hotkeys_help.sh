#!/bin/bash

FILE="${HOME}/.config/hypr/conf/keybinds.conf"

MAINMOD=$(cat "${FILE}" | grep "MAINMOD" | head -1 | sed 's|.* = ||')

mapfile -t keys < <(cat "${FILE}" | \
    grep "bind =" | \
    sed 's|.* = ||' | \
    sed "s|\$MAINMOD|${MAINMOD}|" | \
    sed 's/^\(\([^,]*,\)\{1\}[^,]*\).*/\1/' | \
    sed "s|, R$||" | \
    sed 's|^, ||' | \
    sed "s|.*, [1-9].*||" | \
    sed '/^[[:space:]]*$/d' | \
    sed 's|, 0|, [N]|'
)
mapfile -t comm < <(cat "${FILE}" | \
    grep "bind =" | \
    sed 's|.*#||' | \
    uniq
)

list=$(for ((i=0; i<${#keys[@]}; i++)); do
    printf "%-20s %s\n" "${keys[i]}" "${comm[i]}"
done)

key=$(echo -e "${list}" | \
    rofi -dmenu \
    -p "Hotkey:" \
    -theme-str "window { width: 30%; }" \
    -theme-str "listview { columns: 1; }"
)

