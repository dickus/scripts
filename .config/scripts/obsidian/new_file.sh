#!/bin/bash

BOLD="\033[1m"
BOLD_UNDERLINE="\033[1m\033[4m"
NO_FORMAT="\033[0m"

if [[ -z "$1" ]]; then
    echo -e "Run ${BOLD}new_file.sh -h${NO_FORMAT} or ${BOLD}new_file.sh --help${NO_FORMAT} to see the use of the script."

    exit
fi

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    echo -e "A script to create a new note.\n"

    echo -e "${BOLD_UNDERLINE}Usage:${NO_FORMAT} ${BOLD}new_file.sh${NO_FORMAT} [ [OPTIONS] | \"[FILE NAME]\" ]\n"

    echo -e "${BOLD_UNDERLINE}Arguments:${NO_FORMAT}"
    echo -e "  [FILE NAME]  File name for a new note.\n"

    echo -e "${BOLD_UNDERLINE}Options:${NO_FORMAT}"
    echo -e "  ${BOLD}-h${NO_FORMAT}, ${BOLD}--help${NO_FORMAT}"
    echo -e "  \tPrint help."

    exit
fi

FILE_NAME=$(echo "$1" | tr ' ' '-')
FORMATTED_FILE_NAME=$(date "+%Y-%m-%d")_${FILE_NAME}
DOCS_PATH="$HOME/.docs"
TEMPLATES_DIRECTORY="templates"
DRAFTS_DIRECTORY="drafts"

cd "$HOME" || exit
touch "${DOCS_PATH}/${DRAFTS_DIRECTORY}/${FORMATTED_FILE_NAME}".md

cat "${DOCS_PATH}/${TEMPLATES_DIRECTORY}/note.md" > "${DOCS_PATH}/${DRAFTS_DIRECTORY}/${FORMATTED_FILE_NAME}".md

sed -i "s|{{id}}|${FORMATTED_FILE_NAME}|" "${DOCS_PATH}/${DRAFTS_DIRECTORY}/${FORMATTED_FILE_NAME}".md

cd "${DOCS_PATH}"
nvim "${DRAFTS_DIRECTORY}/${FORMATTED_FILE_NAME}".md

