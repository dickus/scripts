#!/bin/bash

show_error() {
    message="${1}"

    dunstify -u critical -t 3000 "Error" "${message}"

    exit 1
}

get_name() {
    name=$(curl ${URL} | grep "<title>" | sed 's|.*<title>||; s|</title>.*||; s|\ -.*||')

    mkdir -p "${HOME}/Videos/DVR/${name}"
}

download() {
    cd ${HOME}/Videos/DVR/"${name}"

    yt-dlp ${URL} -o "${name}"

    dunstify -t 3000 "YouTube video downloaded" "${name}"
}

audio_exctraction() {
    cd "${HOME}/Videos/DVR/${name}"

    file=$(ls -t "${name}".* 2>/dev/null | head -1)

    echo ${file}

    ffmpeg -i "${file}" -vn -acodec flac "${name}".flac

    dunstify -t 3000 "Audio extracted" "${name}.flac"
}


URL=$(wl-paste)

[[ -z "${URL}" ]] && show_error "Clipboard is empty"

[[ ! "${URL}" =~ ^https://www.youtube.com ]] && show_error "Not YouTube link"

get_name
download
audio_exctraction

