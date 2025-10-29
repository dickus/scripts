#!/usr/bin/env bash

BASE_DIR="${HOME}/.wg"
TERMINAL="kitty"

check_connection() {
    ifconfig | \
    grep "vpn"
}

up() {
    CONNECTION=$(check_connection)

    ! [[ -z "${CONNECTION}" ]] && notify-send -t 3000 -u critical -i ${HOME}/.icons/light/connection_down.svg "VPN" "Already connected" && exit 1

    existing_files=()
    if [[ -d "${BASE_DIR}" ]]; then
        while IFS= read -r file; do
            existing_files+=("${file}")
        done < <(find "${BASE_DIR}" -maxdepth 1 -name "*.conf" -type f -printf "%f\n")
    fi

    filename=$(
        printf "%s\n" "${existing_files[@]}" | \
        rofi -dmenu \
            -p "VPN config:" \
            -i \
            -theme-str "window { width: 20%; }" \
            -theme-str "listview { lines: 5; columns: 2; }"
    )

    [[ -z "${filename}" ]] && exit 0

    ${TERMINAL} -T "popup" -e sudo resolvconf -u
    ${TERMINAL} -T "popup" -e wg-quick up ${BASE_DIR}/"${filename}"

    CONNECTION=$(check_connection)
    filename=$(
        echo "${filename}" | \
        sed 's|^/||; s|\.conf$||'
    )

    notify-send -t 1500 -i ${HOME}/.icons/light/connection_up.svg "VPN" "Connected to ${filename}"
}

down() {
    CONNECTION=$(check_connection)

    if [[ -z "${CONNECTION}" ]]; then
        notify-send -t 3000 -u critical -i ${HOME}/.icons/light/connection_down.svg "VPN" "Connection error"
    else
        for conf_file in "${BASE_DIR}"/*.conf; do
            [[ -e "${conf_file}" ]] || continue

            interface_name=$(basename "${conf_file}")

            ${TERMINAL} -T "popup" -e wg-quick down ${BASE_DIR}/"${interface_name}"
        done

        notify-send -t 1500 -i $HOME/.icons/light/connection_down.svg "VPN" "Connection down"

        nmcli device status | \
        grep "enp.*" | \
        sed "s|[[:space:]].*||" | \
        xargs -ro nmcli device disconnect; nmcli device status | \
        grep "enp.*" | \
        sed "s|[[:space:]].*||" | \
        xargs -ro nmcli device connect
    fi
}

main() {
    mode=$(
        echo -e "up\ndown" | \
        rofi -dmenu \
            -p "Mode:" \
            -i \
            -theme-str "window { width: 7%; }" \
            -theme-str "listview { lines: 2; }"
    )

    [[ -z "${mode}" ]] && exit 0

    ${mode}
}

main

