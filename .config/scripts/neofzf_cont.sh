#!/bin/bash

FILE=$(rg --files --hidden --no-ignore /home 2>/dev/null | fzf --preview="bat {}" --bind "change:reload(rg --ignore-case --hidden --no-ignore --line-number --color always {q} || true)" | sed "s/:.*//" | sed "s/\x1b\[[0-9;]*m//g")

FILE_PATH=$(realpath "$HOME/$FILE")

if [[ -f "$FILE_PATH" ]]; then
    nvim "$FILE_PATH"
fi

