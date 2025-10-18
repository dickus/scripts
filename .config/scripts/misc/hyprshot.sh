#!/usr/bin/env bash

FILE="screen_$(date +%F_%H%M%S)".png
MONITOR=$(hyprctl -j monitors | jq -r '.[] | select(.focused == true) | .name')

case "${1}" in
    screen)
        hyprshot -m output -m "${MONITOR}" -f "${FILE}" ;;

    region)
        hyprshot -m region -f "${FILE}" -z ;;

    window)
        hyprshot -m window -m active -f "${FILE}" ;;
esac

