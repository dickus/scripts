#!/bin/bash

THEME="$1"
LIGHT_THEME="fjord"
DARK_THEME="nord"

CONFIG_DIR="${HOME}/.config"
WALL_DIR="${HOME}/Pictures/wallpapers"

TARGET_THEME="${LIGHT_THEME}"
DIR_MODE="light"
TERMINAL="kitty"

if [[ "${THEME}" == "dark" ]]; then
    TARGET_THEME="${DARK_THEME}"
    DIR_MODE="dark"
fi

declare -A replacements=(
    ["${CONFIG_DIR}/hypr/hyprland.conf"]="s|/dunstrc_.*|/dunstrc_${TARGET_THEME} \&| ; s|/themes/.*.conf|/themes/${TARGET_THEME}.conf|"
    ["${CONFIG_DIR}/hypr/hyprlock.conf"]="s|themes/.*.conf|themes/${TARGET_THEME}.conf|"
    ["${CONFIG_DIR}/nvim/init.lua"]="s|themes.*|themes.${TARGET_THEME}\")|"
    ["${CONFIG_DIR}/rofi/config.rasi"]="s|/themes/.*.rasi|/themes/${TARGET_THEME}.rasi|"
    ["${CONFIG_DIR}/rofi/powermenu.rasi"]="s|/themes/.*.rasi|/themes/${TARGET_THEME}.rasi|"
    ["${CONFIG_DIR}/eww/eww.scss"]="s|themes/.*|themes/${TARGET_THEME}';|"
)

for file in "${!replacements[@]}"; do
    if [[ -f "${file}" ]]; then
        sed -i "${replacements[${file}]}" "${file}"
    fi
done

scripts=(
    system/microphone.sh
    system/volume.sh
    system/vpn.sh
    wallpapers/new_wallpaper.sh
    yazi/isomount.sh
    yazi/isounmount.sh
)

for script in "${scripts[@]}"; do
    file="${CONFIG_DIR}/scripts/${script}"

    if [[ -f "${file}" ]]; then
        sed -i "s|/light/|/${DIR_MODE}/|g; s|/dark/|/${DIR_MODE}/|g" "${file}"
    fi
done

cat "${CONFIG_DIR}/waybar/themes/${TARGET_THEME}.css" > "${CONFIG_DIR}/waybar/style.css"
cat "${CONFIG_DIR}/swayimg/themes/${TARGET_THEME}" > "${CONFIG_DIR}/swayimg/config"

hyprctl reload

if [[ "${TERMINAL}" == "kitty" ]]; then
    if [[ "${DIR_MODE}" == "light" ]]; then
        kitty +kitten themes --reload-in=all "${LIGHT_THEME^}"

        mapfile -t files < <(find ${WALL_DIR}/${LIGHT_THEME} -type f | \
            sort)

        files_count=$(printf "%s\n" "${files[@]}" | \
            wc -l)

        file=$((1 + RANDOM % ${files_count}))
    else
        kitty +kitten themes --reload-in=all "${DARK_THEME^}"

        mapfile -t files < <(find ${WALL_DIR}/${DARK_THEME} -type f | \
            sort)

        files_count=$(printf "%s\n" "${files[@]}" | \
            wc -l)

        file=$((1 + RANDOM % ${files_count}))
    fi
fi

${HOME}/.config/scripts/wallpapers/wall_set.sh "$(printf "%s\n" "${files[@]}" | \
    sed -n "${file}p")"

