#!/usr/bin/env bash

DIR="${HOME}/.docs"
NOTES="${DIR}/notes"
DRAFTS="${DIR}/drafts"
TEMPLATES="${DIR}/templates"
TERMINAL="kitty"

open_note_name() {
    mapfile -t notes < <(find "${DIR}" -type f -printf "%P\n")

    local note=$(
        printf "%s\n" "${notes[@]}" | \
        sed 's|^[^_]*_||; s|.md||' | \
        sort | \
        rofi -dmenu \
            -p "Note:" \
            -i \
            -theme-str "window { width: 25%; }" \
            -theme-str "listview { lines: 10; }"
    )

    [[ -z "${note}" ]] && open_note

    for original_note in "${notes[@]}"; do
        local stripped_note=$(
            echo "${original_note}" | \
            sed 's|^[^_]*_||; s|.md||'
        )

        if [[ "${stripped_note}" == "${note}" ]]; then
            cd ${DIR}

            ${TERMINAL} -e nvim "${original_note}"

            exit 0
        fi
    done
}

open_note_tag() {
    if [[ -d "${DIR}" ]]; then
        mapfile -t tags < <(
            realpath "${DIR}"/* | \
            xargs -r grep -r "\- #" | \
            sed 's|.*#||' | \
            sort | \
            uniq
        )
    fi

    local tag=$(
        printf "%s\n" "${tags[@]}" | \
        rofi -dmenu \
            -p "Tag:" \
            -i \
            -theme-str "window { width: 25%; }" \
            -theme-str "listview { lines: 10; }"
    )

    [[ -z "${tag}" ]] && exit 0
    if [[ -d "${DIR}" ]]; then
        mapfile -t notes < <(
            realpath "${DIR}"/* | \
            xargs -r grep -r "#${tag}" | \
            sed 's|:.*||' | \
            sort
        )
    fi

    local note=$(
        printf "%s\n" "${notes[@]}" | \
        sed 's|^[^_]*_||; s|.md||' | \
        sort | \
        rofi -dmenu \
            -p "Note:" \
            -i \
            -theme-str "window { width: 20%; }" \
            -theme-str "listview { lines: 10; }"
    )

    [[ -z "${note}" ]] && open_note

    for original_note in "${notes[@]}"; do
        local stripped_note=$(
            echo "${original_note}" | \
            sed 's|^[^_]*_||; s|.md||'
        )

        if [[ "${stripped_note}" == "${note}" ]]; then
            cd ${DIR}

            ${TERMINAL} -e nvim "${original_note}"

            exit 0
        fi
    done
}

open_note() {
    local open=$(
        echo -e "By name\nBy tag" | \
        rofi -dmenu \
            -p "Open note:" \
            -i \
            -theme-str "window { width: 7%; }" \
            -theme-str "listview { lines: 2; }"
    )

    [[ -z "${open}" ]] && main

    if [[ "${open}" == "By name" ]]; then
        open_note_name
    elif [[ "${open}" == "By tag" ]]; then
        open_note_tag
    fi
}

new_note() {
    mapfile -t templates < <(find "${TEMPLATES}" -maxdepth 1 -type f -printf "%f\n")

    local template=$(
        printf "%s\n" "${templates[@]}" | \
        sort | \
        rofi -dmenu \
            -p "Template:" \
            -i \
            -theme-str "window { width: 10%; }" \
            -theme-str "listview { lines: $(printf "%s\n" "${templates[@]}" | wc -l); }"
    )

    [[ -z "${template}" ]] && main

    local notes=()
    if [[ -d "${DRAFTS}" ]] && [[ -d "${NOTES}" ]]; then
        mapfile -t drafts < <(
            find "${NOTES}" "${DRAFTS}" -maxdepth 1 -type f -printf "%f\n" | \
            sed -e 's|^[^_]*_||; s|.md||'
        )
    fi

    local filename=$(
        printf "%s\n" "${drafts[@]}" | \
        sort | \
        rofi -dmenu \
            -p "Name:" \
            -i \
            -theme-str "window { width: 30%; }" \
            -theme-str "listview { lines: 10; }"
    )

    [[ -z "${filename}" ]] && new_note

    local filename="${filename%.*}"
    local filename=$(
        echo "${filename}" | \
        tr ' ' '-'
    )
    local dated_file="$(date "+%Y-%m-%d-%H%M%S")_${filename}"
    local target_file="${DRAFTS}/${dated_file}.md"

    cat "${TEMPLATES}/${template}" > "${target_file}"

    sed -i "s|{{id}}|${dated_file}|g" "${target_file}"

    cd ${DIR}

    ${TERMINAL} -e nvim "${target_file}"

    exit 0
}

main() {
    actions=(
        "TODO"
        "Quick note"
        "Open note"
        "New note"
        "Review notes"
    )

    action=$(
        printf "%s\n" "${actions[@]}" | \
        rofi -dmenu \
            -p "Notes:" \
            -i \
            -theme-str "window { width: 10%; }" \
            -theme-str "listview { lines: $( \
                printf "%s\n" "${actions[@]}" | \
                wc -l
            ); }"
    )

    [[ -z "${action}" ]] && exit 0

    case "${action}" in
        "TODO")
            ${TERMINAL} -T "todos" -e nvim ${HOME}/.docs/todos.md ;;
        "Quick note") 
            ${TERMINAL} -T "quicknote" -e nvim ;;
        "Open note")
            open_note ;;
        "New note")
            new_note ;;
        "Review notes")
            cd ${DIR} && ${TERMINAL} -e nvim ${DRAFTS}/*.md

            exit 0 ;;
    esac
}

main

