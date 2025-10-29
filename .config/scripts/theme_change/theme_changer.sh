#!/usr/bin/env bash

BASE_DIR="${HOME}/.config/scripts/theme_change"
THEME_SCRIPT="${BASE_DIR}/theme_schedule.sh"
LIGHT_DIR="${BASE_DIR}/light"
DARK_DIR="${BASE_DIR}/dark"

get_current_theme() {
    grep -oP "${1}=\"\K[^\"]+" "${THEME_SCRIPT}" | \
    tail -1
}

CURRENT_LIGHT=$(get_current_theme "LIGHT_THEME")
CURRENT_DARK=$(get_current_theme "DARK_THEME")


LIGHT_THEMES=()
if [[ -d "${LIGHT_DIR}" ]]; then
    while IFS= read -r file; do
        LIGHT_THEMES+=("${file}")
    done < <(find "${LIGHT_DIR}" -type f -printf "%f\n")
fi

LIGHT_THEME=$(
    printf "%s\n" "${LIGHT_THEMES[@]}" | \
    sort | \
    rofi -dmenu \
        -p "Light:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: $( \
            printf "%s\n" "${LIGHT_THEMES[@]}" | \
            wc -l
        ); }"
)

DARK_THEMES=()
if [[ -d "${DARK_DIR}" ]]; then
    while IFS= read -r file; do
        DARK_THEMES+=("${file}")
    done < <(find "${DARK_DIR}" -type f -printf "%f\n")
fi

DARK_THEME=$(
    printf "%s\n" "${DARK_THEMES[@]}" | \
    sort | \
    rofi -dmenu \
        -p "Dark:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: $( \
            printf "%s\n" "${DARK_THEMES[@]}" | \
            wc -l
        ); }"
)

update_theme() {
    local var_name=${1}
    local new_value=${2}
    local current_value=${3}

    if [[ "${current_value}" != "${new_value}" ]]; then
        sed -i "s|^\(${var_name}=\).*|\1\"${new_value}\"|" "${THEME_SCRIPT}"

        notify-send -t 2000 "Theme changed to ${new_value}"
    fi
}

if ! [[ -z ${LIGHT_THEME} ]]; then
    update_theme "LIGHT_THEME" "${LIGHT_THEME}" "${CURRENT_LIGHT}"
fi

if ! [[ -z ${DARK_THEME} ]]; then
    update_theme "DARK_THEME" "${DARK_THEME}" "${CURRENT_DARK}"
fi

[[ -z ${LIGHT_THEME} ]] && [[ -z ${DARK_THEME} ]] && exit 0

${HOME}/.config/scripts/theme_change/check_time.sh

