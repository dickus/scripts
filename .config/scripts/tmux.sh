#!/bin/bash

TERMINAL="kitty"
LAYOUTS="${HOME}/.config/tmux/layouts"

get_session_name() {
    session_name="$(tmux ls | \
        rofi -dmenu \
        -p "Session name:" \
        -theme-str "window { width: 15%; }" \
        -theme-str "listview { lines: 5; }"
    )"

    [[ -z "${session_name}" ]] && main

    get_directory
}

get_directory() {
    dir_name="$(find ${HOME} -mindepth 2 -maxdepth 3 -type d | \
        sed "s|${HOME}/||" | \
        rofi -dmenu \
        -p "Directory:" \
        -theme-str "window { width: 30%; }" \
        -theme-str "listview { lines: 10; columns: 2; }"
    )"

    [[ -z "${dir_name}" ]] && dir_name="${HOME}/"

    create_session
}

create_session() {
    ${LAYOUTS}/${layout}.sh "${TERMINAL}" "${session_name}" "${dir_name}"

    exit 0
}

main() {
    layout=$(find ${LAYOUTS} -type f | \
        sed 's|.*/||; s|.sh||' | \
        rofi -dmenu \
        -p "Tmux layout:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: $(find ${LAYOUTS} -type f | wc -l); }"
    )

    [[ -z "${layout}" ]] && exit 0

    get_session_name
}

main

