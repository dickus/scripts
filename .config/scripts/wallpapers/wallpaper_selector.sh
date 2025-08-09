#!/bin/bash

WALL_DIR="${HOME}/Pictures/wallpapers"
MODE="$1"

categories=()
if [[ -d "${WALL_DIR}" ]]; then
    while IFS= read -r file; do
        categories+=("${file}")
    done < <(find "${WALL_DIR}" -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
fi

category=$(printf "%s\n" "${categories[@]}" | \
    sort | \
    rofi -dmenu \
    -p "Wallpapers:" \
    -i \
    -theme-str "window { width: 8%; }" \
    -theme-str "listview { lines: $(printf "%s\n" ${categories[@]} | \
        wc -l); }"
)

[[ -z "${category}" ]] && exit 0

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

