#!/usr/bin/env bash

TEMP=$(hyprctl hyprsunset temperature)
BASEDIR="${HOME}/.config/scripts"
THEME_SCRIPT="${BASEDIR}/theme_change/theme_schedule.sh"
STATUS="${BASEDIR}/daylight/daylight"

get_current_theme() {
    grep -oP "${1}=\"\K[^\"]+" "${THEME_SCRIPT}" | \
    tail -1
}

if [[ "${1}" == "toggle" ]]; then
    if [[ -z $(grep "dark" ${HOME}/.config/scripts/audio/microphone.sh) ]]; then
        ${THEME_SCRIPT} dark
    else
        ${THEME_SCRIPT} light
    fi
fi

if [[ "${1}" == "light" ]]; then
    if [[ -z $(grep "Cold" ${STATUS}) ]]; then
        hyprctl hyprsunset identity

        echo "Cold" > ${STATUS}
    else
        hyprctl hyprsunset temperature 4500

        echo "Warm" > ${STATUS}
    fi

    notify-send -t 2000 "Screen color" "$(cat ${STATUS})"
fi

