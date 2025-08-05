#!/bin/bash

BOLD="\033[1m"
NO_FORMAT="\033[0m"

BASE_DIR="${HOME}/Pictures/wallpapers/neutral"

show_error() {
    message="$1"
    if command -v dunstify &> /dev/null; then
        dunstify -u critical -t 3000 -i ${HOME}/.icons/light/gallery_error.svg "Error" "$message"
    else
        echo -e "${BOLD}Error:${NO_FORMAT} $message" >&2
    fi

    exit 1
}

download_wallpaper() {
    local filename="$1"
    local url="$2"
    
    [[ ! "${url}" =~ ^https?:// ]] && show_error "Invalid URL"

    if [[ ! "${filename}" =~ \.(png|jpg|jpeg)$ ]]; then
        clean_url="${url%%\?*}"
        extension="${clean_url##*.}"
        extension_lower="${extension,,}"
        
        [[ "${extension_lower}" =~ ^(png|jpg|jpeg)$ ]] && filename="${filename}.${extension_lower}"
    fi

    if ! curl -L -f -o "${BASE_DIR}/${filename}" "${url}"; then
        show_error "Couldn't download an image: ${url}"
    fi

    if command -v dunstify &> /dev/null; then
        dunstify -t 1500 -i ${HOME}/.icons/light/gallery.svg "New ${mode} wallpaper" "${filename}"
    fi
}

command -v rofi >/dev/null || show_error "'rofi' is required"
command -v dunst >/dev/null || show_error "'dunst' is recommended"

clipboard_content=$(wl-paste 2>/dev/null)

[[ -z "${clipboard_content}" ]] && show_error "Clipboard is empty"

if [[ "${clipboard_content}" =~ ^https?:// ]]; then
    url="${clipboard_content}"
fi

mkdir -p "${BASE_DIR}"

existing_files=()
if [[ -d "${BASE_DIR}" ]]; then
    while IFS= read -r file; do
        existing_files+=("${file}")
    done < <(find "${BASE_DIR}" -maxdepth 1 -type f -printf "%f\n")
fi

filename=$(printf "%s\n" "${existing_files[@]}" | rofi -dmenu \
    -p "Name:" \
    -i \
    -theme-str "window { width: 25%; }" \
    -theme-str "listview { lines: 5; columns: 2; }"
)

[[ -z "${filename}" ]] && exit 0

filename="${filename%.*}"

download_wallpaper "${filename}" "${url}"

