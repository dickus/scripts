#!/bin/bash

case "$1" in
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP "\b\d{1,2}(?=%)" | head -n 1)

        if [[ "$CURRENT_VOLUME" -eq 0 ]]; then
            dunstify -t 1000 -i $HOME/.icons/dark/audio-volume-muted.svg "System sound" "Muted"
        else
            dunstify -t 1000 -i $HOME/.icons/dark/audio-volume-low.svg "Volume down" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
        fi ;;

    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP "\b\d{1,2}(?=%)" | head -n 1)

        dunstify -t 1000 -i $HOME/.icons/dark/audio-volume-high.svg "Volume up" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')" ;;

    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        SYSTEM_SOUND_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | sed "s/Mute: //")

        if [[ "$SYSTEM_SOUND_STATUS" == "yes" ]]; then
            dunstify -t 1000 -i $HOME/.icons/dark/audio-volume-muted.svg "System sound" "Muted"
        else
            dunstify -t 1000 -i $HOME/.icons/dark/audio-volume-high.svg "System sound" "Unmuted"
        fi ;;
esac

