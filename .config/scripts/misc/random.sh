#!/usr/bin/env bash

input=$(
    rofi -dmenu \
        -p "Integer:" \
        -theme-str "window { width: 15%; }" \
        -theme-str "listview { lines: 1; }" \
)


show_error() {
    MSG="${1}"

    notify-send -t 5000 "Error" "${MSG}"

    exit 0
}


if [[ ${input} == *"-"* ]]; then
    IFS="-" read -r start end <<< "${input}"
    
    if ! [[ ${start} =~ ^[1-9][0-9]*$ && ${end} =~ ^[1-9][0-9]*$ ]]; then
        show_error "Are you retarded or something?"
    fi

    if (( start >= end )); then
        show_error "Start cannot be equal to end"
    fi

    range=$(( end - start + 1 ))
    RANDOM_NUMBER=$(( start + RANDOM % range ))
else
    if ! [[ ${input} =~ ^[1-9][0-9]*$ ]]; then
        error_exit
    fi

    RANDOM_NUMBER=$(( 1 + RANDOM % input ))
fi

notify-send -t 5000 "${RANDOM_NUMBER}"
wl-copy "${RANDOM_NUMBER}"

