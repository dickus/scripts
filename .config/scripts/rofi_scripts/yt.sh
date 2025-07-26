#!/bin/bash

show_error() {
    message="$1"

    dunstify -u critical -t 3000 "Error" "$message"

    exit 1
}

get_name() {
    name=$(curl ${URL} | grep "<title>" | sed 's|.*<title>||; s|</title>.*||; s|\ -.*||')

    mkdir -p "$HOME/Videos/DVR/Recordings/${name}"; cd "$HOME/Videos/DVR/Recordings/${name}"
}

download() {
    yt-dlp ${URL} -o "${name}"
}

audio_exctraction() {
    file=$(ls -t "${name}".* 2>/dev/null | head -1)

    ffmpeg -i "${file}" -vn -acodec flac "${name}".flac
}


URL=$(wl-paste)

[[ -z "$URL" ]] && show_error "Clipboard is empty"

[[ ! "$URL" =~ ^https://www.youtube.com ]] && show_error "Not YouTube link"

get_name
download
audio_exctraction

