#!/bin/bash

THEME_SCRIPT="${HOME}/.config/scripts/theme_change/theme_schedule.sh"

get_current_theme() {
    grep -oP "$1=\"\K[^\"]+" "${THEME_SCRIPT}" | tail -n 1
}

CURRENT_LIGHT=$(get_current_theme "LIGHT_THEME")
CURRENT_DARK=$(get_current_theme "DARK_THEME")

LIGHT_THEME=$(echo -e "everforest\ngruvbox\nlatte" | rofi -dmenu \
    -p "Light:" \
    -i \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 3; }"
)

DARK_THEME=$(echo -e "frappe\ngruvbox\nnord" | rofi -dmenu \
    -p "Dark:" \
    -i \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 3; }"
)

update_theme() {
    local var_name=$1
    local new_value=$2
    local current_value=$3

    if [[ "${current_value}" != "${new_value}" ]]; then
        sed -i "s|^\(${var_name}=\).*|\1\"${new_value}\"|" "${THEME_SCRIPT}"

        dunstify -t 2000 "Theme changed to ${new_value}"
    fi
}

if ! [[ -z ${LIGHT_THEME} ]]; then
    if [[ ${LIGHT_THEME} == "gruvbox" ]]; then
        update_theme "LIGHT_THEME" "${LIGHT_THEME}-light" "${CURRENT_LIGHT}"
    else
        update_theme "LIGHT_THEME" "${LIGHT_THEME}" "${CURRENT_LIGHT}"
    fi
fi

if ! [[ -z ${DARK_THEME} ]]; then
    if [[ ${DARK_THEME} == "gruvbox" ]]; then
        update_theme "DARK_THEME" "${DARK_THEME}-dark" "${CURRENT_DARK}"
    else
        update_theme "DARK_THEME" "${DARK_THEME}" "${CURRENT_DARK}"
    fi
fi

${HOME}/.config/scripts/theme_change/check_time.sh

