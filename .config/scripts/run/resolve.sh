#!/bin/bash

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    sed -i "s|follow_mouse = .*|follow_mouse = 3|" "$HOME/.config/hypr/hyprland.conf"

    hyprctl reload
fi

/opt/resolve/bin/resolve "$@"

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    sed -i "s|follow_mouse = .*|follow_mouse = 1|" "$HOME/.config/hypr/hyprland.conf"

    hyprctl reload
fi

