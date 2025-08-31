#!/usr/bin/env bash

FILE=$(find /home -mindepth 1 -type f 2>/dev/null | fzf --preview="bat {}")

[[ -n "${FILE}" ]] && nvim "${FILE}"

