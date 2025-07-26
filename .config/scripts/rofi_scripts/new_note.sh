#!/bin/bash

NOTES_DIR="$HOME/.docs"
TEMPLATES_DIR="$NOTES_DIR/templates"
DRAFTS_DIR="$NOTES_DIR/drafts"
TERMINAL=$1

new_note() {
    local template=$1
    local filename=$(echo "$2" | tr ' ' '-')
    local dated_file="$(date "+%Y-%m-%d-%H%M%S")_${filename}"
    local target_file="${DRAFTS_DIR}/${dated_file}.md"

    cat "${TEMPLATES_DIR}/${template}" > "${target_file}"

    sed -i "s|{{id}}|${dated_file}|g" "${target_file}"

    ${TERMINAL} -e nvim "${target_file}"
}

templates=()
if [[ -d "$TEMPLATES_DIR" ]]; then
    while IFS= read -r file; do
        templates+=("$file")
    done < <(find "$TEMPLATES_DIR" -maxdepth 1 -type f -printf "%f\n")
fi

template=$(printf "%s\n" "${templates[@]}" | sort | rofi -dmenu \
    -p "Template:" \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 5; }"
)

[[ -z "$template" ]] && exit 0

drafts=()
if [[ -d "$DRAFTS_DIR" ]]; then
    while IFS= read -r file; do
        new_file=$(echo "$file" | sed -e "s|^[^_]*_||" -e "s|\.md||")

        drafts+=("$new_file")
    done < <(find "$DRAFTS_DIR" -maxdepth 1 -type f -printf "%f\n")
fi

filename=$(printf "%s\n" "${drafts[@]}" | sort | rofi -dmenu \
    -p "Name:" \
    -theme-str "window { width: 30%; }" \
    -theme-str "listview { lines: 5; columns: 2; }"
)

[[ -z "$filename" ]] && exit 0

filename="${filename%.*}"

new_note "$template" "$filename"

