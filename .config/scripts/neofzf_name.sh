#!/bin/bash

FILE=$(find /home -mindepth 1 -type f 2>/dev/null | fzf --preview="bat {}")

if [[ -n "$FILE" ]]; then
    nvim "$FILE"
fi

