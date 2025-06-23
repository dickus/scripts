#!/bin/bash

BOLD="\033[1m"
NO_FORMAT="\033[0m"

BASE_DIR="$HOME/Pictures/wallpapers"

show_error() {
    message="$1"
    if command -v dunstify &> /dev/null; then
        dunstify -t 2000 -i $HOME/.icons/light/gallery_error.svg "Error" "$message"
    else
        echo -e "${BOLD}Error:${NO_FORMAT} $message" >&2
    fi

    exit 1
}

download_wallpaper() {
    local mode="$1"
    local filename="$2"
    local url="$3"
    
    [[ "$mode" != "dark" && "$mode" != "light" ]] && exit 1

    [[ ! "$url" =~ ^https?:// ]] && show_error "Invalid URL"

    if [[ ! "$filename" =~ \.(png|jpg|jpeg)$ ]]; then
        clean_url="${url%%\?*}"
        extension="${clean_url##*.}"
        extension_lower="${extension,,}"
        
        [[ "$extension_lower" =~ ^(png|jpg|jpeg)$ ]] && filename="${filename}.${extension_lower}"
    fi

    target_dir="$BASE_DIR/$mode"
    mkdir -p "$target_dir"

    if ! curl -L -f -o "$target_dir/$filename" "$url"; then
        show_error "Couldn't download an image: $url"
    fi

    if command -v dunstify &> /dev/null; then
        dunstify -t 1000 -i $HOME/.icons/light/gallery.svg "New $mode wallpaper" "$filename"
    fi
}

command -v rofi >/dev/null || show_error "'rofi' is required"
command -v xclip >/dev/null || show_error "'xclip' is required"

clipboard_content=$(xclip -sel clipboard -o 2>/dev/null)
[[ -z "$clipboard_content" ]] && show_error "Clipboard is empty"

if [[ "$clipboard_content" =~ ^https?:// ]]; then
    url="$clipboard_content"
fi

mode=$(echo -e "☀️ light\n🌙 dark" | rofi -dmenu \
    -p "Mode:" \
    -mesg "$url_message" \
    -theme-str "window { width: 10%; }" \
    -theme-str "listview { lines: 2; }")

mode=$(echo "$mode" | awk '{print $NF}')
[[ -z "$mode" ]] && exit 0

target_dir="$BASE_DIR/$mode"
mkdir -p "$target_dir"

existing_files=()
if [[ -d "$target_dir" ]]; then
    while IFS= read -r file; do
        existing_files+=("$file")
    done < <(find "$target_dir" -maxdepth 1 -type f -printf "%f\n")
fi

filename=$(printf "%s\n" "${existing_files[@]}" | rofi -dmenu \
    -p "Name:" \
    -theme-str "window { width: 25%; }" \
    -theme-str "listview { lines: 5; columns: 2; }")

[[ -z "$filename" ]] && exit 0

filename="${filename%.*}"

download_wallpaper "$mode" "$filename" "$url"

