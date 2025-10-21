#!/usr/bin/env bash

IMAGES="${HOME}/Pictures"

find "${IMAGES}" -maxdepth 1 -type f -iname "*.png" -printf "%f\n" | \
    sort -r | \
    fzf \
    --layout=reverse \
    --preview-window=right:65% \
    --preview="kitty +kitten icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 "${IMAGES}"/{}" \
    --bind="ctrl-c:execute(wl-copy < "${IMAGES}"/{} &>/dev/null)+abort" \
    --bind="ctrl-g:execute(setsid -f org.gimp.GIMP "${IMAGES}"/{} &>/dev/null &)+abort" \
    --bind="ctrl-d:execute(mv "${IMAGES}"/{} "${HOME}"/.local/share/Trash)+reload(find "${IMAGES}" -maxdepth 1 -type f -iname \"*.png\" -printf \"%f\n\" | sort -r)" \
    --bind="return:execute(setsid -f swayimg "${IMAGES}"/{} &>/dev/null)+abort"

