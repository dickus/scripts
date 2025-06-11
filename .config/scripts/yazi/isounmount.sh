#!/bin/bash

fusermount -u $HOME/mnt

dunstify -t 1000 -i $HOME/.icons/light/disc-unmount.svg "ISO unmounted"

