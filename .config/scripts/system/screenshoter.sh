#!/usr/bin/env bash

FILE="screen_$(date +%F_%H%M%S)".png
SCREEN_DIR="${HOME}/Pictures"

CLIP="wl-copy --type=image/png"

case "${1}" in
    screen)
        grim "${SCREEN_DIR}/${FILE}" && ${CLIP} < "${SCREEN_DIR}/${FILE}" ;;

    region)
        grim -g "$(slurp)" "${SCREEN_DIR}/${FILE}" && ${CLIP} < "${SCREEN_DIR}/${FILE}" ;;

    window)
        AT=$(hyprctl activewindow | grep "at: [0-9]" | sed "s|[[:space:]]*at: ||")
        SIZE=$(hyprctl activewindow | grep "size: [0-9]" | sed "s|[[:space:]]*size: ||; s|,|x|")

        grim -g "${AT} ${SIZE}" "${SCREEN_DIR}/${FILE}" && ${CLIP} < "${SCREEN_DIR}/${FILE}" ;;
esac

if [[ -f "${SCREEN_DIR}/${FILE}" ]]; then
    dunstify -t 3000 -i "${SCREEN_DIR}/${FILE}" "Screenshot saved" "${FILE}"
fi

