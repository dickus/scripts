#!/bin/bash

BOLD="\033[1m"
BOLD_UNDERLINE="\033[1m\033[4m"
NO_FORMAT="\033[0m"

BASE_DIR="$HOME/Pictures/wallpapers"

BASIC_USE="Run ${BOLD}new_wallpaper.sh -h${NO_FORMAT} or ${BOLD}new_wallpaper.sh --help${NO_FORMAT} to see the use of the script."

if [[ "$#" -ne 1 ]] && [[ "$#" -ne 3 ]]; then
    echo -e ${BASIC_USE}

    exit
fi

if [[ "$#" -eq 1 ]]; then
    if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
        echo -e "A script to add new wallpapers.\n"

        echo -e "${BOLD_UNDERLINE}Usage:${NO_FORMAT}  ${BOLD}new_wallpaper.sh${NO_FORMAT} [OPTIONS] [NAME] [URL]"
        echo -e "\t${BOLD}new_wallpaper.sh${NO_FORMAT} [OPTIONS]\n"

        echo -e "${BOLD_UNDERLINE}Arguments:${NO_FORMAT}"
        echo -e "  [NAME]  File name for a new wallpaper."
        echo -e "  [URL]   Link to an image needed to be added as a wallpaper.\n"

        echo -e "${BOLD_UNDERLINE}Options:${NO_FORMAT}"
        echo -e "  ${BOLD}-h${NO_FORMAT}, ${BOLD}--help${NO_FORMAT}"
        echo -e "  \tPrint help."
        echo -e "  ${BOLD}-d${NO_FORMAT}, ${BOLD}-l${NO_FORMAT}"
        echo -e "  \tSet new wallpaper as ${BOLD}d${NO_FORMAT}ark or ${BOLD}l${NO_FORMAT}ight."

        exit
    fi
fi

if [[ "$1" == "-d" ]]; then
    MODE="dark"
elif [[ "$1" == "-l" ]]; then
    MODE="light"
else
    echo -e ${BASIC_USE}

    exit
fi

if [[ "$3" == http://* || "$3" == https://* ]]; then
    URL="$3"
else
    echo -e ${BASIC_USE}

    exit
fi

if ! [[ -d "$BASE_DIR/$MODE" ]]; then
    mkdir -p "$BASE_DIR/$MODE"
fi

curl -o "$BASE_DIR/$MODE/$2" "$URL"

