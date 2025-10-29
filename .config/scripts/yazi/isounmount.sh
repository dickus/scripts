#!/usr/bin/env bash

fusermount -u ${HOME}/mnt

notify-send -t 3000 -i ${HOME}/.icons/light/disc-unmount.svg "ISO unmounted"

