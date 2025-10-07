#!/usr/bin/env bash

TEMP=$(hyprctl hyprsunset temperature)

DAY=""
NIGHT="󰖔"

THEME_SCRIPT="${HOME}/.config/scripts/theme_change/theme_schedule.sh"
STATUS="${HOME}/.config/scripts/daylight/daylight"

get_current_theme() {
    grep -oP "${1}=\"\K[^\"]+" "${THEME_SCRIPT}" | tail -n 1
}

if [[ $(grep "6000" ${STATUS}) ]]; then
    printf '{"text": "%s"}' "${DAY}"
else
    printf '{"text": "%s", "class": "on"}' "${NIGHT}"
fi

if [[ "${1}" == "toggle" ]]; then
    if [[ -z $(grep "dark" ${HOME}/.config/scripts/audio/microphone.sh) ]]; then
        ${THEME_SCRIPT} dark
    else
        ${THEME_SCRIPT} light
    fi
fi

if [[ "${1}" == "light" ]]; then
    if [[ -z $(grep "6000" ${STATUS}) ]]; then
        hyprctl hyprsunset identity

        echo "6000" > ${STATUS}
    else
        hyprctl hyprsunset temperature 4500

        echo "4500" > ${STATUS}
    fi
fi

