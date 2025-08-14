#!/bin/bash

DIR="${HOME}/.docs"
NOTES="${DIR}/notes"
DRAFTS="${DIR}/drafts"
TEMPLATES="${DIR}/templates"
TERMINAL="kitty"

open_note_name() {
    local dir="$1"
    mapfile -t notes < <(find "${dir}" -type f -printf "%f\n")

    local note=$(printf "%s\n" "${notes[@]}" | \
        sed 's|^[^_]*_||' | \
        sort | \
        rofi -dmenu \
        -p "Note:" \
        -i \
        -theme-str "window { width: 20%; }" \
        -theme-str "listview { lines: 10; }"
    )

    [[ -z "${note}" ]] && open_note

    for original_note in "${notes[@]}"; do
        local stripped_note=$(echo "${original_note}" | sed 's|^[^_]*_||')

        if [[ "${stripped_note}" == "${note}" ]]; then
            cd ${DIR}

            ${TERMINAL} -e nvim "${dir}/${original_note}"

            exit 0
        fi
    done
}

open_note_tag() {
    local dir="$1"
    if [[ -d "${dir}" ]]; then
        mapfile -t tags < <(realpath "${dir}"/* | \
        xargs -r grep -r "\- #" | \
        sed 's|.*#||' | \
        sort | \
        uniq)
    fi

    local tag=$(printf "%s\n" "${tags[@]}" | rofi -dmenu \
        -p "Tag:" \
        -i \
        -theme-str "window { width: 20%; }" \
        -theme-str "listview { lines: 10; }"
    )

    [[ -z "${tag}" ]] && exit 0
    if [[ -d "${dir}" ]]; then
        mapfile -t notes < <(realpath "${dir}"/* | \
        xargs -r grep -r "#${tag}" | \
        sed 's|:.*||' | \
        sort)
    fi

    local note=$(printf "%s\n" "${notes[@]}" | \
        sed 's|^[^_]*_||' | \
        sort | \
        rofi -dmenu \
        -p "Note:" \
        -i \
        -theme-str "window { width: 20%; }" \
        -theme-str "listview { lines: 10; }"
    )

    [[ -z "${note}" ]] && open_note

    for original_note in "${notes[@]}"; do
        local stripped_note=$(echo "${original_note}" | sed 's|^[^_]*_||')

        if [[ "${stripped_note}" == "${note}" ]]; then
            cd ${DIR}

            ${TERMINAL} -e nvim "${original_note}"

            exit 0
        fi
    done
}

open_note() {
    local dir="$1"
    local open=$(echo -e "By name\nBy tag" | rofi -dmenu \
        -p "Open note:" \
        -i \
        -theme-str "window { width: 7%; }" \
        -theme-str "listview { lines: 2; }"
    )

    [[ -z "${open}" ]] && main

    if [[ "${open}" == "By name" ]]; then
        open_note_name "${dir}"
    elif [[ "${open}" == "By tag" ]]; then
        open_note_tag "${dir}"
    fi
}

new_note() {
    mapfile -t templates < <(find "${TEMPLATES}" -maxdepth 1 -type f -printf "%f\n")

    local template=$(printf "%s\n" "${templates[@]}" | \
        sort | \
        rofi -dmenu \
        -p "Template:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: 4; }"
    )

    [[ -z "${template}" ]] && main

    local notes=()
    if [[ -d "${DRAFTS}" ]] && [[ -d "${NOTES}" ]]; then
        mapfile -t drafts < <(find "${NOTES}" "${DRAFTS}" -maxdepth 1 -type f -printf "%f\n" | sed -e 's|^[^_]*_||; s|.md||')
    fi

    local filename=$(printf "%s\n" "${drafts[@]}" | \
        sort | \
        rofi -dmenu \
        -p "Name:" \
        -i \
        -theme-str "window { width: 30%; }" \
        -theme-str "listview { lines: 10; }"
    )

    [[ -z "${filename}" ]] && new_note

    local filename="${filename%.*}"

    local filename=$(echo "${filename}" | tr ' ' '-')
    local dated_file="$(date "+%Y-%m-%d-%H%M%S")_${filename}"
    local target_file="${DRAFTS}/${dated_file}.md"

    cat "${TEMPLATES}/${template}" > "${target_file}"

    sed -i 's|{{id}}|${dated_file}|g' "${target_file}"

    cd ${DIR}

    ${TERMINAL} -e nvim "${target_file}"

    exit 0
}

main() {
    action=$(echo -e "Quick note\nOpen note\nOpen draft\nNew note\nReview notes" | rofi -dmenu \
        -p "Notes:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: 5; }"
    )

    [[ -z "${action}" ]] && exit 0

    case "${action}" in
        "Quick note") ${TERMINAL} -T "quicknote" -e nvim ;;
        "Open note") open_note "${NOTES}" ;;
        "Open draft") open_note "${DRAFTS}" ;;
        "New note") new_note ;;
        "Review notes")
            cd ${DIR} && ${TERMINAL} -e nvim ${DRAFTS}/*.md

            exit 0 ;;
    esac
}

main

