#!/bin/bash

THEME="$1"
LIGHT_THEME="latte"
DARK_THEME="frappe"

CONFIG_DIR="$HOME/.config"

TARGET_THEME="$LIGHT_THEME"
DIR_MODE="light"

if [[ "$THEME" == "dark" ]]; then
    TARGET_THEME="$DARK_THEME"
    DIR_MODE="dark"
fi

declare -A replacements=(
    ["$CONFIG_DIR/alacritty/alacritty.toml"]="s|/themes/.*.toml|/themes/$TARGET_THEME.toml|"
    ["$CONFIG_DIR/bspwm/bspwmrc"]="s|/themes/.*.sh|/themes/$TARGET_THEME.sh|"
    ["$CONFIG_DIR/kitty/kitty.conf"]="s|themes/.*.conf|themes/$TARGET_THEME.conf|"
    ["$CONFIG_DIR/nvim/init.lua"]="s|themes.*|themes.$TARGET_THEME\")|"
    ["$CONFIG_DIR/polybar/config.ini"]="s|/themes/.*.ini|/themes/$TARGET_THEME.ini|"
    ["$CONFIG_DIR/rofi/config.rasi"]="s|/themes/.*.rasi|/themes/$TARGET_THEME.rasi|"
    ["$CONFIG_DIR/rofi/powermenu.rasi"]="s|/themes/.*.rasi|/themes/$TARGET_THEME.rasi|"
    ["$CONFIG_DIR/zellij/config.kdl"]="s|theme .*|themes \"$TARGET_THEME\"|"
)

for file in "${!replacements[@]}"; do
    if [[ -f "$file" ]]; then
        sed -i "${replacements[$file]}" "$file"
    fi
done

scripts=(
    microphone.sh
    volume.sh
    vpn.sh
    screenshoter.sh
)

for script in "${scripts[@]}"; do
    file="$CONFIG_DIR/scripts/$script"

    if [[ -f "$file" ]]; then
        sed -i "s|/light/|/$DIR_MODE/|g; s|/dark/|/$DIR_MODE/|g" "$file"
    fi
done

