#!/bin/bash

theme="$1"
light_theme="latte"
dark_theme="frappe"

case $theme in
    light)
        sed -i "s|/themes/.*.toml|/themes/$light_theme.toml|" $HOME/.config/alacritty/alacritty.toml
        sed -i "s|/themes/.*.sh|/themes/$light_theme.sh|" $HOME/.config/bspwm/bspwmrc
        sed -i "s|themes/.*.conf|themes/$light_theme.conf|" $HOME/.config/kitty/kitty.conf
        sed -i "s|themes.*|themes.$light_theme\")|" $HOME/.config/nvim/init.lua
        sed -i "s|/themes/.*.ini|/themes/$light_theme.ini|" $HOME/.config/polybar/config.ini
        sed -i "s|/themes/.*.rasi|/themes/$light_theme.rasi|" $HOME/.config/rofi/config.rasi
        sed -i "s|/themes/.*.rasi|/themes/$light_theme.rasi|" $HOME/.config/rofi/powermenu.rasi
        sed -i "s|theme .*|theme \"$light_theme\"|" $HOME/.config/zellij/config.kdl
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/microphone.sh
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/volume.sh
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/vpn.sh
        sed -i "s|/dark/|/light/|" $HOME/.config/scripts/screenshoter.sh ;;

    dark)
        sed -i "s|/themes/.*.toml|/themes/$dark_theme.toml|" $HOME/.config/alacritty/alacritty.toml
        sed -i "s|/themes/.*.sh|/themes/$dark_theme.sh|" $HOME/.config/bspwm/bspwmrc
        sed -i "s|themes/.*.conf|themes/$dark_theme.conf|" $HOME/.config/kitty/kitty.conf
	sed -i "s|themes.*|themes.$dark_theme\")|" $HOME/.config/nvim/init.lua
        sed -i "s|/themes/.*.ini|/themes/$dark_theme.ini|" $HOME/.config/polybar/config.ini
        sed -i "s|/themes/.*.rasi|/themes/$dark_theme.rasi|" $HOME/.config/rofi/config.rasi
        sed -i "s|/themes/.*.rasi|/themes/$dark_theme.rasi|" $HOME/.config/rofi/powermenu.rasi
        sed -i "s|theme .*|theme \"$dark_theme\"|" $HOME/.config/zellij/config.kdl
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/microphone.sh
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/volume.sh
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/vpn.sh
        sed -i "s|/light/|/dark/|" $HOME/.config/scripts/screenshoter.sh ;;
esac

