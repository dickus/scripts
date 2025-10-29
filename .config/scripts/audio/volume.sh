#!/usr/bin/env bash

current_volume() {
    CURRENT_VOLUME=$(
        pactl get-sink-volume @DEFAULT_SINK@ | \
        grep -oP "\b\d{1,2}(?=%)" | \
        head -1
    )

    echo "${CURRENT_VOLUME}"
}

case "$1" in
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%

        if [[ $(current_volume) -eq 0 ]]; then
            notify-send -t 1000 -i ${HOME}/.icons/light/audio-volume-muted.svg "System sound" "Muted"
        else
            notify-send -t 1000 -i ${HOME}/.icons/light/audio-volume-low.svg "Volume down" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
        fi ;;

    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%

        notify-send -t 1000 -i ${HOME}/.icons/light/audio-volume-high.svg "Volume up" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')" ;;

    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        SYSTEM_SOUND_STATUS=$(
            pactl get-sink-mute @DEFAULT_SINK@ | \
            sed "s/Mute: //"
        )

        if [[ "${SYSTEM_SOUND_STATUS}" == "yes" ]]; then
            notify-send -t 1000 -i ${HOME}/.icons/light/audio-volume-muted.svg "System sound" "Muted"
        else
            notify-send -t 1000 -i ${HOME}/.icons/light/audio-volume-high.svg "System sound" "Unmuted"
        fi ;;
esac

