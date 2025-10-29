#!/usr/bin/env bash

WALL_DIR="${HOME}/Pictures/wallpapers"
MODE="${1}"

get_unique_files() {
    declare -A hashes
    while IFS= read -r -d $'\0' file; do
        if [[ -f "${file}" ]]; then
            hash=$(
                md5sum "${file}" | \
                awk '{ print $1 }'
            )

            if [ -z "${hashes[${hash}]}" ]; then
                hashes[${hash}]=1
                printf "%s\0" "${file[@]}"
            fi
        fi
    done
}

manual() {
    find "${WALL_DIR}" -type f -print0 | \
    get_unique_files | \
    sort -z | \
    xargs -0 -r swayimg -g
}

random() {
    local files=()
    while IFS= read -r -d $'\0' file; do
        files+=("${file}")
    done < <(
        find "${WALL_DIR}" -type f -print0 | \
        get_unique_files | \
        sort -z
    )

    local files_count="${#files[@]}"
    if [[ "${files_count}" -eq 0 ]]; then
        exit 0
    fi

    local index=$(( RANDOM % files_count ))

    "${HOME}/.config/scripts/wallpapers/wall_set.sh" "${files[${index}]}"
}

if [[ "${MODE}" == "random" ]]; then
    random
else
    manual
fi

