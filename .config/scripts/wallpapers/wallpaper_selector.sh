#!/bin/bash

WALL_DIR="${HOME}/Pictures/wallpapers/all"
MODE="$1"

manual() {
    find ${WALL_DIR}/${category} -type f | \
        sort | \
        xargs -r swayimg -g
}

random() {
    mapfile -t files < <(find ${WALL_DIR}/${category} -type f | \
        sort)

    files_count=$(printf "%s\n" "${files[@]}" | \
        wc -l)

    file=$((1 + RANDOM % ${files_count}))

    ${HOME}/.config/scripts/wallpapers/wall_set.sh "$(printf "%s\n" "${files[@]}" | \
        sed -n "${file}p")"
}

if [[ "${MODE}" == "random" ]]; then
    random
else
    manual
fi

