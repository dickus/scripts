#!/bin/bash

current_theme="$(cat $HOME/.config/scripts/microphone.sh | grep -oP 'icons/.*/' | head -n 1 | sed 's|icons/\([^/]*\)/|\1|')"

current_time=$(date +%-H%M)
evening_time=1930
morning_time=800


if [[ "$current_time" -ge "$evening_time" || "$current_time" -lt "$morning_time" ]]; then
    if [[ "$current_theme" != "dark" ]]; then
        ./.config/scripts/theme_change/theme_schedule.sh dark
        sed -i 's|bat --theme .*"|bat --theme gruvbox-dark"|' $HOME/.zshrc
    fi
else
    if [[ "$current_theme" != "light" ]]; then
        ./.config/scripts/theme_change/theme_schedule.sh light
        sed -i 's|bat --theme .*"|bat --theme gruvbox-light"|' $HOME/.zshrc
    fi
fi

