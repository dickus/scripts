#!/bin/bash

FILE=$(rg --files --hidden --no-ignore /home 2>/dev/null | fzf --preview="cat {}" --bind "change:reload(rg --ignore-case --hidden --no-ignore --line-number --color=never {q} || true)" | sed "s/:.*//" | sed -r "s/\x1b\[[0-9;]*[mK]//g")

FILE_PATH=$(realpath "${FILE}")

[[ -f "${FILE_PATH}" ]] && nvim "${FILE_PATH}"

