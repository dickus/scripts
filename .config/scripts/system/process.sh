#!/bin/bash

get_process() {
    local process_list=$(ps --no-headers -eo pid,comm,pmem --sort=-%mem | \
        awk '{printf "%-7s: %-25s %8s\n", $1, $2, $3}'
    )

    local process=$(echo "${process_list}" | \
        rofi -dmenu \
        -p "Process:" \
        -i \
        -theme-str "window { width: 20%; }" \
        -theme-str "listview { columns: 1; }"
    )

    local pid=$(echo "${process}" | \
        awk -F: '{print $1}'
    )

    [[ -z "${process}" ]] && exit 0

    action "${pid}"
}

action() {
    local pid="${1}"

    local signals=(
        TERM
        KILL
    )

    local signal=$(printf "%s\n" "${signals[@]}" | \
        rofi -dmenu \
        -p "Process:" \
        -i \
        -theme-str "window { width: 6%; }" \
        -theme-str "listview { lines: $(printf "%s\n" "${signals[@]}" | wc -l); }"
    )

    if [[ -z "${signal}" ]]; then
        local pid=""

        get_process
    fi

    kill -"${signal}" "${pid}" && dunstify -t 2000 "Process killed" "PID: ${pid}"
}

get_process

