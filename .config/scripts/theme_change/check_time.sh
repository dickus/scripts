#!/bin/bash

CURRENT_THEME="$(cat $HOME/.config/scripts/microphone.sh | grep -oP 'icons/.*/' | head -n 1 | sed 's|icons/\([^/]*\)/|\1|')"

CURRENT_TIME=$(date +%-H%M)
EVENING_TIME=1930
MORNING_TIME=800


if [[ "$CURRENT_TIME" -ge "$EVENING_TIME" || "$CURRENT_TIME" -lt "$MORNING_TIME" ]]; then
    if [[ "$CURRENT_THEME" != "dark" ]]; then
        ./.config/scripts/theme_change/theme_schedule.sh dark
        sed -i 's|bat --theme .*"|bat --theme gruvbox-dark"|' $HOME/.zshrc
    fi
else
    if [[ "$CURRENT_THEME" != "light" ]]; then
        ./.config/scripts/theme_change/theme_schedule.sh light
        sed -i 's|bat --theme .*"|bat --theme gruvbox-light"|' $HOME/.zshrc
    fi
fi

