#!/bin/bash

ISO="$1"
MOUNT_DIR="$HOME/mnt"

cleanup() {
    if mountpoint -q "$MOUNT_DIR"; then
        fusermount -zu "$MOUNT_DIR" 2>/dev/null
    fi

    rm -d "$MOUNT_DIR" 2>/dev/null
}

mkdir -p "$MOUNT_DIR"

cleanup

if fuseiso -p "$ISO" "$MOUNT_DIR"; then
    dunstify -t 3000 -i $HOME/.icons/dark/disc.svg "ISO mounted" "$(basename "$ISO")"
else
    cleanup

    exit 1
fi

