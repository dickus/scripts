#!/usr/bin/env bash

hyprctl keyword input:follow_mouse 3

/opt/resolve/bin/resolve "$@"

hyprctl keyword input:follow_mouse 1

