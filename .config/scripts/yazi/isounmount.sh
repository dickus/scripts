#!/bin/bash

fusermount -u $HOME/mnt

dunstify -t 3000 -i $HOME/.icons/dark/disc-unmount.svg "ISO unmounted"

