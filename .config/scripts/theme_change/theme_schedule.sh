#!/bin/bash

THEME="$1"
LIGHT_THEME="latte"
DARK_THEME="frappe"

case $THEME in
    light)
        sed -i "s|/themes/.*.toml|/themes/$LIGHT_THEME.toml|" $HOME/.config/alacritty/alacritty.toml
        sed -i "s|/themes/.*.sh|/themes/$LIGHT_THEME.sh|" $HOME/.config/bspwm/bspwmrc
        sed -i "s|themes/.*.conf|themes/$LIGHT_THEME.conf|" $HOME/.config/kitty/kitty.conf
        sed -i "s|themes.*|themes.$LIGHT_THEME\")|" $HOME/.config/nvim/init.lua
        sed -i "s|/themes/.*.ini|/themes/$LIGHT_THEME.ini|" $HOME/.config/polybar/config.ini
        sed -i "s|/themes/.*.rasi|/themes/$LIGHT_THEME.rasi|" $HOME/.config/rofi/config.rasi
        sed -i "s|/themes/.*.rasi|/themes/$LIGHT_THEME.rasi|" $HOME/.config/rofi/powermenu.rasi
        sed -i "s|theme .*|theme \"$LIGHT_THEME\"|" $HOME/.config/zellij/config.kdl
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/microphone.sh
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/volume.sh
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/vpn.sh
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/screenshoter.sh ;;

    dark)
        sed -i "s|/themes/.*.toml|/themes/$DARK_THEME.toml|" $HOME/.config/alacritty/alacritty.toml
        sed -i "s|/themes/.*.sh|/themes/$DARK_THEME.sh|" $HOME/.config/bspwm/bspwmrc
        sed -i "s|themes/.*.conf|themes/$DARK_THEME.conf|" $HOME/.config/kitty/kitty.conf
	sed -i "s|themes.*|themes.$DARK_THEME\")|" $HOME/.config/nvim/init.lua
        sed -i "s|/themes/.*.ini|/themes/$DARK_THEME.ini|" $HOME/.config/polybar/config.ini
        sed -i "s|/themes/.*.rasi|/themes/$DARK_THEME.rasi|" $HOME/.config/rofi/config.rasi
        sed -i "s|/themes/.*.rasi|/themes/$DARK_THEME.rasi|" $HOME/.config/rofi/powermenu.rasi
        sed -i "s|theme .*|theme \"$DARK_THEME\"|" $HOME/.config/zellij/config.kdl
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/microphone.sh
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/volume.sh
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/vpn.sh
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/screenshoter.sh ;;
esac

