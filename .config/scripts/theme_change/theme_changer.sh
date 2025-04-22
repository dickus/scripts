#!/bin/bash

BOLD="\033[1m"
BOLD_UNDERLINE="\033[1;4m"
NO_FORMAT="\033[0m"

LIGHT_THEMES=("everforest" "gruvbox" "latte")
DARK_THEMES=("frappe" "gruvbox" "nord")

THEME_SCRIPT="$HOME/.config/scripts/theme_change/theme_schedule.sh"

get_current_theme() {
    grep -oP "$1=\"\K[^\"]+" "$THEME_SCRIPT" | tail -n 1
}

CURRENT_LIGHT=$(get_current_theme "LIGHT_THEME")
CURRENT_DARK=$(get_current_theme "DARK_THEME")

mark_current_themes() {
    local -n arr=$1
    local current=$2

    for i in "${!arr[@]}"; do
        if [[ "${arr[i]}" == "$current" ]]; then
            arr[i]="${arr[i]} <"
        fi
    done
}

mark_current_themes LIGHT_THEMES "$CURRENT_LIGHT"
mark_current_themes DARK_THEMES "$CURRENT_DARK"

if [[ $# -eq 0 ]]; then
    echo -e "Run ${BOLD}theme_changer.sh -h${NO_FORMAT} or ${BOLD}--help${NO_FORMAT} to see the use of the script."
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo -e "A script to change themes.\n"

            echo -e "${BOLD_UNDERLINE}Usage:${NO_FORMAT}  ${BOLD}theme_changer.sh${NO_FORMAT} [LIGHT THEME] [DARK THEME]"
            echo -e "\t${BOLD}theme_changer.sh${NO_FORMAT} [OPTIONS]\n"

            echo -e "${BOLD_UNDERLINE}Arguments:${NO_FORMAT}"
            echo -e "  [LIGHT THEME]  Set light theme."
            echo -e "  [DARK THEME]   Set dark theme.\n"

            echo -e "${BOLD_UNDERLINE}Options:${NO_FORMAT}"
            echo -e "  ${BOLD}-h${NO_FORMAT}, ${BOLD}--help${NO_FORMAT}"
            echo -e "  \tPrint help."
            echo -e "  ${BOLD}-t${NO_FORMAT}, ${BOLD}--theme${NO_FORMAT}"
            echo -e "  \tShow current themes."

            exit ;;
        -t|--theme)
            echo -e "${BOLD_UNDERLINE}Themes:${NO_FORMAT}"
            printf "${BOLD}%-15s %s${NO_FORMAT}\n" "Light themes" "Dark themes"
            max_len=$((${#LIGHT_THEMES[@]} > ${#DARK_THEMES[@]} ? ${#LIGHT_THEMES[@]} : ${#DARK_THEMES[@]}))

            for (( i = 0; i < max_len; i++ )); do
                printf "%-15s %s\n" "${LIGHT_THEMES[i]:-}" "${DARK_THEMES[i]:-}"
            done

            exit ;;
        *)
            break ;;
    esac
done

if [[ $# -ne 2 ]]; then
    echo -e "Run ${BOLD}theme_changer.sh -h${NO_FORMAT} or ${BOLD}--help${NO_FORMAT} to see the use of the script."
fi

LIGHT=$1
DARK=$2

validate_theme() {
    local theme=$1
    shift
    local -n themes=$1

    for t in "${themes[@]}"; do
        if [[ "$t" == "$theme" ]]; then
            return 0
        fi
    done

    echo -e "${BOLD}Error:${NO_FORMAT} '$theme' is not found."

    return 1
}

validate_theme "$LIGHT" LIGHT_THEMES || exit 1
validate_theme "$DARK" DARK_THEMES || exit 1

update_theme() {
    local var_name=$1
    local new_value=$2
    local current_value=$3

    if [[ "$current_value" != "$new_value" ]]; then
        sed -i "s/^\($var_name=\).*/\1\"$new_value\"/" "$THEME_SCRIPT"
        echo -e "Theme $var_name changed to ${BOLD}'$new_value'${NO_FORMAT}."
    else
        echo -e "Theme is already set to ${BOLD}'$new_value'${NO_FORMAT}"
    fi
}

update_theme "light_theme" "$LIGHT" "$CURRENT_LIGHT"
update_theme "dark_theme" "$DARK" "$CURRENT_DARK"

