#!/bin/bash

process_list=$(ps --no-headers -eo pid,comm,pmem --sort=-%mem | \
    awk '{printf "%-7s: %-25s %8s\n", $1, $2, $3}'
)

process=$(echo "${process_list}" | \
    rofi -dmenu \
    -p "Process:" \
    -i \
    -theme-str "window { width: 20%; }" \
    -theme-str "listview { columns: 1; }"
)

pid=$(echo "${process}" | \
    awk -F: '{print $1}'
)

name=$(echo "${process}" | \
    awk -F: '{print $2}'
)

[[ -z "${process}" ]] && exit 0

kill -9 "${pid}" && dunstify -t 2000 "Process killed" "Command:${name}\nPID: ${pid}"

