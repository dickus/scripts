#!/usr/bin/env bash

eww_config="${HOME}/.config/eww/eww.yuck"
current_theme="${HOME}/.config/hypr/lock_themes/$(cat ${HOME}/.config/hypr/hyprlock.conf | head -1 | sed 's|.*/||')"

positions=(
    "1. top left"
    "4. center left"
    "7. bottom left"
    "2. top center"
    "5. center center"
    "8. bottom center"
    "3. top right"
    "6. center right"
    "9. bottom right"
)

position=$(printf "%s\n" "${positions[@]}" | \
    rofi -dmenu \
    -p "Clock position:" \
    -i \
    -theme-str "window { width: 25%; }" \
    -theme-str "listview { lines: 3; columns: 3; }"
)

[[ -z "${position}" ]] && exit 0

position=$(echo "${position}" | sed 's|^[0-9]\. ||')

sed -i "s|:anchor.*|:anchor \"${position}\"|" "${eww_config}"

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

case "${position}" in
    "top left")
        sed -i "23s|=.*|= ${left_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${left_date}, ${top_date}|" "${current_theme}" ;;
    "top center")
        sed -i "23s|=.*|= ${hmid_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${hmid_date}, ${top_date}|" "${current_theme}" ;;
    "top right")
        sed -i "23s|=.*|= ${right_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${right_date}, ${top_date}|" "${current_theme}" ;;
    "center left")
        sed -i "23s|=.*|= ${left_clock}, ${vmid_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${left_date}, ${vmid_date}|" "${current_theme}" ;;
    "center center")
        sed -i "23s|=.*|= ${hmid_clock}, ${top_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${hmid_date}, ${top_date}|" "${current_theme}" ;;
    "center right")
        sed -i "23s|=.*|= ${right_clock}, ${vmid_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${right_date}, ${vmid_date}|" "${current_theme}" ;;
    "bottom left")
        sed -i "23s|=.*|= ${left_clock}, ${bottom_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${left_date}, ${bottom_date}|" "${current_theme}" ;;
    "bottom center")
        sed -i "23s|=.*|= ${hmid_clock}, ${bottom_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${hmid_date}, ${bottom_date}|" "${current_theme}" ;;
    "bottom right")
        sed -i "23s|=.*|= ${right_clock}, ${bottom_clock}|" "${current_theme}"
        sed -i "37s|=.*|= ${right_date}, ${bottom_date}|" "${current_theme}" ;;
esac

