#!/bin/bash

file=$(rg --files --hidden --no-ignore /home 2>/dev/null | fzf --preview="bat {}" --bind "change:reload(rg --ignore-case --hidden --no-ignore --line-number --color always {q} || true)" | sed "s/:.*//" | sed "s/\x1b\[[0-9;]*m//g")

file_path=$(realpath "$HOME/$file")

if [[ -f "$file_path" ]]; then
    nvim "$file_path"
fi

