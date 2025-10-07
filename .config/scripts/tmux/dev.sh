#!/usr/bin/env bash

TERMINAL="kitty"
PROJECTS="${HOME}/projects"

get_session_name() {
    session_name="$(tmux ls | \
        sed 's|:.*||' | \
        rofi -dmenu \
        -p "Session name:" \
        -theme-str "window { width: 15%; }" \
        -theme-str "listview { lines: 5; }"
    )"

    [[ -z "${session_name}" ]] && exit 0

    get_project
}

get_project() {
    project_name="$(find "${PROJECTS}" -maxdepth 2 -type d | \
        sed "s|${HOME}/||" | \
        rofi -dmenu \
        -p "Project:" \
        -theme-str "window { width: 30%; }" \
        -theme-str "listview { lines: 10; columns: 2; }"
    )"

    [[ -z "${project_name}" ]] && get_session_name

    create_session
}

create_session() {
    tmux has-session -t "${session_name}"

    if [[ $? != 0 ]]; then
        cd "${HOME}/${project_name}"

        tmux new-session -ds "${session_name}"
        tmux set-window-option -t "${session_name}" allow-rename off
        tmux rename-window -t "${session_name}":1 random-overview

        tmux send-keys -t "${session_name}":1.1 'yazi' C-m
        tmux split-window -h -p 70 -t "${session_name}":1
        tmux send-keys -t "${session_name}":1.2 'nvim' C-m

        tmux select-pane -t 1
        tmux split-window -v -p 25 -t "${session_name}":1

        tmux select-pane -t 1
    fi

    ${TERMINAL} -e tmux a -t "${session_name}"
}

get_session_name

