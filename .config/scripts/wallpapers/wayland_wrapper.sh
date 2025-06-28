#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/1000
export WAYLAND_DISPLAY=wayland-1
export XDG_SESSION_TYPE=wayland

$HOME/.config/scripts/wallpapers/wallpaper_changer.sh

