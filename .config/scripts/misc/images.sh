#!/usr/bin/env zsh

IMAGES="${HOME}/Pictures"
IMAGE_EDITOR_SCRIPT="${HOME}/.config/scripts/open_image_editor"

find "${IMAGES}" -maxdepth 1 -type f \( \
    -iname "*.png"  -o \
    -iname "*.jpg"  -o \
    -iname "*.jpeg" -o \
    -iname "*.ico" \
    \) -printf "%f\n" | \
sort -r | \
fzf \
    --cycle \
    --layout=reverse \
    --preview-window=right:65% \
    --preview="kitty +kitten icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 "${IMAGES}"/{}" \
    --bind="ctrl-c:execute(wl-copy < "${IMAGES}"/{} &>/dev/null)+abort" \
    --bind="ctrl-e:execute("${IMAGE_EDITOR_SCRIPT}" "${IMAGES}"/{})+abort" \
    --bind="ctrl-d:execute(mv "${IMAGES}"/{} "${HOME}"/.local/share/Trash)+reload(find "${IMAGES}" -maxdepth 1 -type f \( -iname \"*.png\" -o -iname \"*.jpg\" -o -iname \"*.jpeg\" -o -iname \"*.ico\" \) -printf \"%f\n\" | sort -r)" \
    --bind="return:execute(setsid -f swayimg "${IMAGES}"/{} &>/dev/null)+abort" \
    --bind="ctrl-a:execute(swappy -f "${IMAGES}"/{} &>/dev/null)+abort"

