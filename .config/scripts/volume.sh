#!/bin/bash

volume_change="$1"

case "$volume_change" in
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP "\b\d{1,2}(?=%)" | head -n 1)

        if [[ "$current_volume" -eq 0 ]]; then
            dunstify -t 1000 -i $HOME/.icons/light/audio-volume-muted.svg "System sound" "Muted"
        else
            dunstify -t 1000 -i $HOME/.icons/light/audio-volume-low.svg "Volume down" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
        fi ;;

    up)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP "\b\d{1,2}(?=%)" | head -n 1)

        dunstify -t 1000 -i $HOME/.icons/light/audio-volume-high.svg "Volume up" "$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')" ;;

    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        system_sound_status=$(pactl get-sink-mute @DEFAULT_SINK@ | sed "s/Mute: //")

        if [[ "$system_sound_status" == "yes" ]]; then
            dunstify -t 1000 -i $HOME/.icons/light/audio-volume-muted.svg "System sound" "Muted"
        else
            dunstify -t 1000 -i $HOME/.icons/light/audio-volume-high.svg "System sound" "Unmuted"
        fi ;;
esac

