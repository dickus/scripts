#!/bin/bash

light="$1"
dark="$2"

light_themes=("everforest" "gruvbox" "latte")
dark_themes=("frappe" "gruvbox" "nord")

max_length=$(( ${#light_themes[@]} > ${#dark_themes[@]} ? ${#light_themes[@]} : ${#dark_themes[@]} ))

current_light="$(cat $HOME/.config/scripts/theme_change/theme_schedule.sh | grep -oP 'light_theme="\K[^"]+' | head -n 1)"
current_dark="$(cat $HOME/.config/scripts/theme_change/theme_schedule.sh | grep -oP 'dark_theme="\K[^"]+' | tail -n 1)"


for theme_index in "${!light_themes[@]}"; do
    theme="${light_themes[$theme_index]}"
    if [[ "$current_light" == *"$theme"* ]]; then
        light_themes[$theme_index]="* $theme"
    fi
done

for theme_index in "${!dark_themes[@]}"; do
    theme="${dark_themes[$theme_index]}"
    if [[ "$current_dark" == *"$theme"* ]]; then
        dark_themes[$theme_index]="* $theme"
    fi
done


if [[ "$#" -ne 1 ]] && [[ "$#" -ne 2 ]]; then
    echo -e "Run \033[1mtheme help\033[0m to see the use of the script."

    exit
fi

if [[ "$1" == "help" ]]; then
    echo -e "\033[1mtheme <light_theme> <dark_theme>\033[0m\n"
    printf "\033[1m%-15s %s\033[0m\n" "Light themes" "Dark themes"

    for ((i = 0; i < max_length; i++)); do
        light_list=${light_themes[i]:-}
        dark_list=${dark_themes[i]:-}

        printf "%-15s %s\n" "$light_list" "$dark_list"
    done

    exit
fi


if ! [[ "${light_themes[@]}" =~ "$light" ]] || ! [[ "${dark_themes[@]}" =~ "$dark" ]]; then
    echo "Incorrect themes input."
    echo -e "Run \033[1mtheme\033[0m with no arguments to see how to use it."

    exit
elif ! [[ "${light_themes[@]}" =~ "$light" ]]; then
    echo "Incorrect light theme input."
    echo -e "Run \033[1mtheme\033[0m with no arguments to see how to use it."

    exit
elif ! [[ "${dark_themes[@]}" =~ "$dark" ]]; then
    echo "Incorrect dark theme input."
    echo -e "Run \033[1mtheme\033[0m with no arguments to see how to use it."

    exit
fi


if [[ "$current_light" != "$light" ]]; then
    sed -i "s|^light_theme=.*|light_theme=\"$light\"|" $HOME/.config/scripts/theme_change/theme_schedule.sh

    echo -e "Light theme is changed to \033[1m'$light'\033[0m."
else
    echo -e "Light theme is already set to \033[1m'$light'\033[0m."
fi

if [[ "$current_dark" != "$dark" ]]; then
    sed -i "s|^dark_theme=.*|dark_theme=\"$dark\"|" $HOME/.config/scripts/theme_change/theme_schedule.sh

    echo -e "Dark theme is changed to \033[1m'$dark'\033[0m."
else
    echo -e "Dark theme is already set to \033[1m'$dark'\033[0m."
fi

