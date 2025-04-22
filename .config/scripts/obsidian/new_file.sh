#!/bin/bash

BOLD="\033[1m"
BOLD_ULINE="\033[1;4m"
NO_FORMAT="\033[0m"

DOCS_PATH="$HOME/.docs"
DEFAULT_TEMPLATE="note"
DRAFTS_DIR="drafts"
TEMPLATES_DIR="templates"

FILE_NAME=""
SELECTED_TEMPLATE=""
TARGET_DIR=""


show_help() {
    echo -e "A script to create a new note.\n"

    echo -e "${BOLD_ULINE}Usage:${NO_FORMAT}  ${BOLD}${0##*/}${NO_FORMAT} [OPTIONS]"
    echo -e "\t${BOLD}${0##*/}${NO_FORMAT} \"[FILE NAME]\""
    echo -e "\t${BOLD}${0##*/}${NO_FORMAT} \"[FILE NAME]\" [OPTIONS]\n"

    echo -e "${BOLD_ULINE}Arguments:${NO_FORMAT}"
    echo -e "  [FILE NAME]  File name for a new note.\n"

    echo -e "${BOLD_ULINE}Options:${NO_FORMAT}"
    echo -e "  ${BOLD}-h${NO_FORMAT}, ${BOLD}--help${NO_FORMAT}"
    echo -e "\tPrint help."

    echo -e "  ${BOLD}-l${NO_FORMAT}, ${BOLD}--list${NO_FORMAT}"
    echo -e "\tShow available templates."

    echo -e "  ${BOLD}-t${NO_FORMAT}, ${BOLD}--template NAME${NO_FORMAT}"
    echo -e "\tUse specified template (default: ${DEFAULT_TEMPLATE})."
}

list_templates() {
    local template_path="${DOCS_PATH}/${TEMPLATES_DIR}"

    echo -e "${BOLD_ULINE}Templates:${NO_FORMAT}"
    find "${template_path}" -name '*.md' -printf "%f\n" |
         sed 's/\.md$//' |
         awk -v default_template="${DEFAULT_TEMPLATE}" '{
             if ($0 == default_template)
                 print $0 " *";
             else
                 print $0
         }'
}

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help

                exit ;;
            -l|--list)
                list_templates

                exit ;;
            -t|--template)
                SELECTED_TEMPLATE="$2"

                shift 2 ;;
            -*)
                echo -e "${BOLD}Error:${NO_FORMAT} Unknown option: $1" >&2

                exit 1 ;;
            *)
                FILE_NAME="$1"

                shift

                while [[ $# -gt 0 ]]; do
                    case $1 in
                        -t|--template)
                            SELECTED_TEMPLATE="$2"

                            shift 2;;
                        -*|*)
                            shift ;;
                    esac
                done ;;
        esac
    done

    [[ -z "$FILE_NAME" ]] && {
        echo -e "Run ${BOLD}new_file.sh -h${NO_FORMAT} or ${BOLD}new_file.sh --help${NO_FORMAT} to see the use of the script."

        exit 1
    }
}

create_note() {
    local file_name=$(echo "$1" | tr ' ' '-')
    local dated_file="$(date "+%Y-%m-%d-%H%M%S")_${file_name}"
    local template="${SELECTED_TEMPLATE:-${DEFAULT_TEMPLATE}}"
    local template_path="${DOCS_PATH}/${TEMPLATES_DIR}/${template}.md"
    local target_dir="${DOCS_PATH}/${DRAFTS_DIR}"
    local target_file="${target_dir}/${dated_file}.md"

    [[ ! -f "${template_path}" ]] && {
        echo -e "${BOLD}Error:${NO_FORMAT} Template '${template}' not found!"

        list_templates

        exit 1
    }

    mkdir -p "${target_dir}" || exit 1

    cp "${template_path}" "${target_file}" || {
        echo "Failed to create file: ${target_file}" >&2

        exit 1
    }

    sed -i "s|{{id}}|${dated_file}|g" "${target_file}"

    nvim "${target_file}"
}

parse_arguments "$@"
create_note "$FILE_NAME"

