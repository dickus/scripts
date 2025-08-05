#!/bin/bash

DIR="${HOME}/.docs"
NOTES="${DIR}/notes"
DRAFTS="${DIR}/drafts"
TEMPLATES="${DIR}/templates"
TERMINAL="kitty"

open_note_name() {
    dir="$1"
    notes=()
    if [[ -d "${dir}" ]]; then
        while IFS= read -r file; do
            notes+=("${file}")
        done < <(find "${dir}" -type f -printf "%f\n")
    fi

    note=$(printf "%s\n" "${notes[@]}" | \
        sed 's|^[^_]*_||' | \
        sort | \
        rofi -dmenu \
        -p "Note:" \
        -i \
        -theme-str "window { width: 20%; }" \
        -theme-str "listview { lines: 10; }"
    )

    [[ -z "${note}" ]] && exit 0

    for original_note in "${notes[@]}"; do
        stripped_note=$(echo "${original_note}" | sed 's|^[^_]*_||')

        if [[ "${stripped_note}" == "${note}" ]]; then
            ${TERMINAL} -e nvim "${dir}/${original_note}"

            break
        fi
    done
}

open_note_tag() {
    dir="$1"
    if [[ -d "${dir}" ]]; then
        mapfile -t tags < <(realpath "${dir}"/* | \
        xargs -r grep -r "\- #" | \
        sed 's|.*#||' | \
        sort | \
        uniq)
    fi

    tag=$(printf "%s\n" "${tags[@]}" | rofi -dmenu \
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

    note=$(printf "%s\n" "${notes[@]}" | \
        sed 's|^[^_]*_||' | \
        sort | \
        rofi -dmenu \
        -p "Note:" \
        -i \
        -theme-str "window { width: 20%; }" \
        -theme-str "listview { lines: 10; }"
    )

    [[ -z "${note}" ]] && exit 0

    for original_note in "${notes[@]}"; do
        stripped_note=$(echo "${original_note}" | sed 's|^[^_]*_||')

        if [[ "${stripped_note}" == "${note}" ]]; then
            ${TERMINAL} -e nvim "${original_note}"

            break
        fi
    done
}

open_note() {
    dir="$1"
    open=$(echo -e "By name\nBy tag" | rofi -dmenu \
        -p "Open note:" \
        -i \
        -theme-str "window { width: 7%; }" \
        -theme-str "listview { lines: 2; }"
    )

    [[ -z "${open}" ]] && exit 0

    if [[ "${open}" == "By name" ]]; then
        open_note_name "${dir}"
    elif [[ "${open}" == "By tag" ]]; then
        open_note_tag "${dir}"
    fi
}

new_note() {
    templates=()
    if [[ -d "${TEMPLATES}" ]]; then
        while IFS= read -r file; do
            templates+=("${file}")
        done < <(find "${TEMPLATES}" -maxdepth 1 -type f -printf "%f\n")
    fi

    template=$(printf "%s\n" "${templates[@]}" | \
        sort | \
        rofi -dmenu \
        -p "Template:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: 4; }"
    )

    [[ -z "${template}" ]] && exit 0

    drafts=()
    if [[ -d "${DRAFTS}" ]]; then
        while IFS= read -r file; do
            drafts+=($(echo "${file}" | sed -e "s|^[^_]*_||"))
        done < <(find "${DRAFTS}" -maxdepth 1 -type f -printf "%f\n")
    fi

    filename=$(printf "%s\n" "${drafts[@]}" | \
        sort | \
        rofi -dmenu \
        -p "Name:" \
        -i \
        -theme-str "window { width: 30%; }" \
        -theme-str "listview { lines: 10; }"
    )

    [[ -z "${filename}" ]] && exit 0

    filename="${filename%.*}"

    local filename=$(echo "${filename}" | tr ' ' '-')
    local dated_file="$(date "+%Y-%m-%d-%H%M%S")_${filename}"
    local target_file="${DRAFTS}/${dated_file}.md"

    cat "${TEMPLATES}/${template}" > "${target_file}"

    sed -i "s|{{id}}|${dated_file}|g" "${target_file}"

    ${TERMINAL} -e nvim "${target_file}"
}

action=$(echo -e "Open note\nOpen draft\nNew note\nReview notes" | rofi -dmenu \
    -p "Action:" \
    -i \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 4; }"
)

[[ -z "${action}" ]] && exit 0

if [[ "${action}" == "Open note" ]]; then
    open_note "${NOTES}"
elif [[ "${action}" == "Open draft" ]]; then
    open_note "${DRAFTS}"
elif [[ "${action}" == "New note" ]]; then
    new_note
elif [[ "${action}" == "Review notes" ]]; then
    cd ${DIR} && ${TERMINAL} -e nvim drafts/*.md
fi

