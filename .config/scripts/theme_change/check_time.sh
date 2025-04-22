#!/bin/bash

CURRENT_THEME="$(cat $HOME/.config/scripts/microphone.sh | grep -oP 'icons/.*/' | head -n 1 | sed 's|icons/\([^/]*\)/|\1|')"
DESIRED_THEME=""

CURRENT_TIME=$(date +%-H%M)
EVENING_TIME=1930
MORNING_TIME=800

THEME_SCRIPT="$HOME/.config/scripts/theme_change/theme_schedule.sh"


main() {
    if (( 10#$CURRENT_TIME >= 1930 || 10#$CURRENT_TIME < 800 )); then
        DESIRED_THEME="dark"
    else
        DESIRED_THEME="light"
    fi

    if [[ "$CURRENT_THEME" != "$DESIRED_THEME" ]]; then
        "$THEME_SCRIPT" "$DESIRED_THEME"
        sed -i 's|bat --theme .*"|bat --theme gruvbox-${DESIRED_THEME}"|' $HOME/.zshrc
    fi
}

main

