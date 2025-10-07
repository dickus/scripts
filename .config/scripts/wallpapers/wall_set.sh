#!/usr/bin/env bash

WALL_PATH=$(echo "${1}" | sed 's|.*/Pictures/||')
WALL=$(echo "${WALL_PATH}" | sed 's|.*/||; s|_.*||')

eww_config="${HOME}/.config/eww/eww.yuck"
eww_cs="${HOME}/.config/eww/eww.scss"
current_theme="${HOME}/.config/hypr/lock_themes/$(cat ${HOME}/.config/hypr/hyprlock.conf | head -1 | sed 's|.*/||')"

echo "${current_theme}"

top_clock="390"
top_date="336"

vmid_clock="21"
vmid_date="-33"

bottom_clock="-347"
bottom_date="-401"

left_clock="-702"
left_date="-539"

hmid_clock="-115"
hmid_date="48"

right_clock="471"
right_date="634"

case "${WALL}" in
    "tl")
        sed -i "23s|=.*|= ${left_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${left_date}, ${top_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"top left\"|" "${eww_config}" ;;
    "tc")
        sed -i "23s|=.*|= ${hmid_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${hmid_date}, ${top_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"top center\"|" "${eww_config}" ;;
    "tr")
        sed -i "23s|=.*|= ${right_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${right_date}, ${top_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"top right\"|" "${eww_config}" ;;
    "cl")
        sed -i "23s|=.*|= ${left_clock}, ${vmid_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${left_date}, ${vmid_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"center left\"|" "${eww_config}" ;;
    "cc")
        sed -i "23s|=.*|= ${hmid_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${hmid_date}, ${top_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"center center\"|" "${eww_config}" ;;
    "cr")
        sed -i "23s|=.*|= ${right_clock}, ${vmid_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${right_date}, ${vmid_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"center right\"|" "${eww_config}" ;;
    "bl")
        sed -i "23s|=.*|= ${left_clock}, ${bottom_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${left_date}, ${bottom_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"bottom left\"|" "${eww_config}" ;;
    "bc")
        sed -i "23s|=.*|= ${hmid_clock}, ${bottom_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${hmid_date}, ${bottom_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"bottom center\"|" "${eww_config}" ;;
    "br")
        sed -i "23s|=.*|= ${right_clock}, ${bottom_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${right_date}, ${bottom_date}|" "${current_theme}"
        sed -i "s|:anchor.*|:anchor \"bottom right\"|" "${eww_config}" ;;
esac

swww img "${1}" --transition-type center

sed -i "s|wallpapers/.*|${WALL_PATH}|" ${HOME}/.config/hypr/hyprlock.conf

