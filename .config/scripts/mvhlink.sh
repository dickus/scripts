#!/bin/bash

BOLD="\033[1m"
BOLD_UNDERLINE="\033[1m\033[4m"
NO_FORMAT="\033[0m"

if [[ "$#" -ne 3 ]] && [[ "$#" -ne 1 ]]; then
    echo -e "Run ${BOLD}mvhlink.sh -h${NO_FORMAT} or ${BOLD}new_file.sh --help${NO_FORMAT} to see the use of the script."

    exit
fi

if [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
    echo -e "A script to rename all hard links for the file.\n"

    echo -e "${BOLD_UNDERLINE}Usage:${NO_FORMAT} ${BOLD}mvhlink.sh${NO_FORMAT} [ [OPTIONS] | [SEARCH PATH] [LINK PATH] [NEW NAME] ]\n"

    echo -e "${BOLD_UNDERLINE}Arguments:${NO_FORMAT}"
    echo -e "  [SEARCH PATH]  Where to search. The path may be actual or relative. For script to work in current directory it can be used with a dot symbol: ${BOLD}mvhlink.sh${NO_FORMAT} . [LINK PATH] [NEW NAME]"
    echo -e "  [LINK PATH]    What link to rename. The path may be actual or relative."
    echo -e "  [NEW NAME]     New name for hard links.\n"

    echo -e "${BOLD_UNDERLINE}Options:${NO_FORMAT}"
    echo -e "  ${BOLD}-h${NO_FORMAT}, ${BOLD}--help${NO_FORMAT}"
    echo -e "  \tPrint help."

    exit
fi

find "${1}" -samefile "${2}" -exec sh -c 'mv "$0" "$(dirname "$0")/'"${3}"'"' {} \;

