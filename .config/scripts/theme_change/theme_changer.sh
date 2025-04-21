#!/bin/bash

BOLD="\033[1m"
BOLD_UNDERLINE="\033[1m\033[4m"
NO_FORMAT="\033[0m"

LIGHT="$1"
DARK="$2"

LIGHT_THEMES=("everforest" "gruvbox" "latte")
DARK_THEMES=("frappe" "gruvbox" "nord")

MAX_LENGTH=$(( ${#LIGHT_THEMES[@]} > ${#DARK_THEMES[@]} ? ${#LIGHT_THEMES[@]} : ${#DARK_THEMES[@]} ))

CURRENT_LIGHT="$(cat $HOME/.config/scripts/theme_change/theme_schedule.sh | grep -oP 'light_theme="\K[^"]+' | head -n 1)"
CURRENT_DARK="$(cat $HOME/.config/scripts/theme_change/theme_schedule.sh | grep -oP 'dark_theme="\K[^"]+' | tail -n 1)"


for THEME_INDEX in "${!LIGHT_THEMES[@]}"; do
    THEME="${LIGHT_THEMES[$THEME_INDEX]}"
    if [[ "$CURRENT_LIGHT" == *"$THEME"* ]]; then
        LIGHT_THEMES[$THEME_INDEX]="* $THEME"
    fi
done

for THEME_INDEX in "${!DARK_THEMES[@]}"; do
    THEME="${DARK_THEMES[$THEME_INDEX]}"
    if [[ "$CURRENT_DARK" == *"$THEME"* ]]; then
        DARK_THEMES[$THEME_INDEX]="* $THEME"
    fi
done


if [[ "$#" -ne 1 ]] && [[ "$#" -ne 2 ]]; then
    echo -e "Run ${BOLD}theme_changer.sh -h${NO_FORMAT} or ${BOLD}--help${NO_FORMAT} to see the use of the script."

    exit
fi

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    echo -e "A script to change themes.\n"

    echo -e "${BOLD_UNDERLINE}Usage:${NO_FORMAT} ${BOLD}theme_changer.sh${NO_FORMAT} [LIGHT THEME] [DARK THEME]"

    echo -e "${BOLD_UNDERLINE}Arguments:${NO_FORMAT}"
    echo -e "  [LIGHT THEME]  Set light theme."
    echo -e "  [DARK THEME]   Set dark theme.\n"

    echo -e "${BOLD_UNDERLINE}Options:${NO_FORMAT}"
    echo -e "  ${BOLD}-h${NO_FORMAT}, ${BOLD}--help${NO_FORMAT}"
    echo -e "  \tPrint help."
    echo -e "  ${BOLD}-t${NO_FORMAT}, ${BOLD}--theme${NO_FORMAT}"
    echo -e "  \tShow current themes."

    exit
fi

if [[ "$1" == "-t" ]] || [[ "$1" == "--theme" ]]; then
    echo -e "${BOLD_UNDERLINE}Current themes:${NO_FORMAT}"
    printf "${BOLD}%-15s %s${NO_FORMAT}\n" "Light themes" "Dark themes"

    for ((i = 0; i < MAX_LENGTH; i++)); do
        light_list=${LIGHT_THEMES[i]:-}
        dark_list=${DARK_THEMES[i]:-}

        printf "  %-15s %s\n" "$light_list" "$dark_list"
    done

    exit
fi


if ! [[ "${LIGHT_THEMES[@]}" =~ "$LIGHT" ]] || ! [[ "${DARK_THEMES[@]}" =~ "$DARK" ]]; then
    echo "Incorrect themes input."
    echo -e "Run ${BOLD}theme_changer.sh${NO_FORMAT} with no arguments to see how to use it."

    exit
elif ! [[ "${LIGHT_THEMES[@]}" =~ "$LIGHT" ]]; then
    echo "Incorrect light theme input."
    echo -e "Run ${BOLD}theme_changer.sh${NO_FORMAT} with no arguments to see how to use it."

    exit
elif ! [[ "${DARK_THEMES[@]}" =~ "$DARK" ]]; then
    echo "Incorrect dark theme input."
    echo -e "Run ${BOLD}theme_changer.sh${NO_FORMAT} with no arguments to see how to use it."

    exit
fi


if [[ "$CURRENT_LIGHT" != "$LIGHT" ]]; then
    sed -i "s|^light_theme=.*|light_theme=\"$LIGHT\"|" $HOME/.config/scripts/theme_change/theme_schedule.sh

    echo -e "Light theme is changed to ${BOLD}'$LIGHT'${NO_FORMAT}."
else
    echo -e "Light theme is already set to ${BOLD}'$LIGHT'${NO_FORMAT}."
fi

if [[ "$CURRENT_DARK" != "$DARK" ]]; then
    sed -i "s|^dark_theme=.*|dark_theme=\"$DARK\"|" $HOME/.config/scripts/theme_change/theme_schedule.sh

    echo -e "Dark theme is changed to ${BOLD}'$DARK'${NO_FORMAT}."
else
    echo -e "Dark theme is already set to ${BOLD}'$DARK'${NO_FORMAT}."
fi

