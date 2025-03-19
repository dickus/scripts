#!/bin/bash

file=$(find /home -mindepth 1 -type f 2>/dev/null | fzf --preview="bat {}")

if [[ -n "$file" ]]; then
    nvim "$file"
fi

