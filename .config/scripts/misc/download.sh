#!/usr/bin/env bash

show_error() {
    MSG="${1}"

    notify-send -t 3000 -u critical "Error" "${MSG}"
}

show_success() {
    MSG="${1}"

    notify-send -t 2000 "Downloaded" "${MSG}"
}

get_video_name() {
    name=$(
        curl ${URL} | \
        grep "<title>" | \
        sed 's|.*<title>||; s|</title>.*||; s|\ -.*||'
    )
    VIDEODIR=""

    if [[ -z "${name}" ]]; then
        VIDEODIR="${HOME}/Videos/DVR/Downloaded"
    else
        VIDEODIR="${HOME}/Videos/DVR/${name}"
    fi

    mkdir -p "${VIDEODIR}"

    echo "${VIDEODIR}"
}

download_video() {
    local url="${1}"
    local name_dir=$(get_video_name)

    if [[ -z "${url}" || -z "${name_dir}" ]]; then
        show_error "Missing URL or video name"

        exit 1
    fi

    yt-dlp -o "${name_dir}/%(title)s.%(ext)s" "${url}"

    if find "${name_dir}" -mindepth 1 -maxdepth 1 -print -quit 2> /dev/null | grep -q .; then
        show_success "${name_dir}"

        extract_audio "${name_dir}"
    else
        show_error "Download failed for ${name_dir}"
    fi
}

extract_audio() {
    local name_dir="${1}"

    if [[ ! -d "${name_dir}" ]]; then
        show_error "Directory ${name_dir} not found"

        exit 1
    fi

    local file_to_convert=$(
        find "${name_dir}" -maxdepth 1 -type f ! -name "*.flac" -printf '%T@\t%p' | \
        sort -nr | \
        head -n 1 | \
        cut -f2
    )

    if [[ -z "${file_to_convert}" ]]; then
        show_error "No new video file found to convert in ${name_dir}"

        exit 1
    fi

    local base_name=$(
        basename "${file_to_convert}" | \
        sed 's/\.[^.]*$//'
    )
    local output_file="${name_dir}/${base_name}.flac"

    notify-send -t 1500 "Converting" "${file_to_convert} to ${output_file}"

    ffmpeg -i "${file_to_convert}" -vn -acodec flac "${output_file}" -loglevel error

    if [[ $? -eq 0 ]]; then
        show_success "${base_name}.flac"
    else
        show_error "Failed to extract audio from ${file_to_convert}"
    fi
}

get_filename() {
    local filename
    
    filename=$(
        rofi -dmenu \
            -p "Image name:" \
            -i \
            -theme-str "window { width: 15%; }" \
            -theme-str "listview { lines: 1; columns: 1; }"
    )
    local exit_code=$?

    [[ "${exit_code}" -ne 0 ]] && exit 1

    if [[ -z "${filename}" ]]; then
        local clean_url="${URL%%\?*}"

        filename=$(basename "${clean_url}")
    fi

    if [[ -z "${filename}" ]]; then
        return 1
    fi
    
    echo "${filename}"
}

download_image() {
    local target_dir="${HOME}/Pictures"
    local url_base="${URL%%\?*}"
    local url_ext="${url_base##*.}"
    local final_filename=""

    while true; do
        local proposed_name
        
        proposed_name=$(
            rofi -dmenu \
                -p "Image name:" \
                -i \
                -theme-str "window { width: 15%; }" \
                -theme-str "listview { lines: 1; columns: 1; }" \
        )

        local exit_code=$?

        if [[ "${exit_code}" -ne 0 ]]; then
            exit 0
        fi

        if [[ -z "${proposed_name}" ]]; then
            proposed_name="$(
                echo "${url_base}" | \
                sed 's|.*/||'
            )"
        fi

        final_filename=$(
            echo "${proposed_name}" | \
            sed "s|\.${url_ext}.*|\.${url_ext}|"
        )

        if [[ ! -f "${target_dir}/${final_filename}" ]]; then
            break
        else
            show_error "File ${final_filename} already exists"

            initial_filename="${final_filename}"
        fi
    done

    wget -O "${target_dir}/${final_filename}" "${URL}"

    if [[ $? -eq 0 && -f "${target_dir}/${final_filename}" ]]; then
        show_success "${final_filename}"
    else
        show_error "Couldn't download image to ${target_dir}/${final_filename}"
    fi
}

download_other() {
    local url="${1}"
    local filename
    
    filename=$(get_filename)
    
    if [[ $? -ne 0 || -z "${filename}" ]]; then
        show_error "Download cancelled or filename invalid"

        exit 0
    fi

    local target_file="${HOME}/Downloads/${filename}"
    
    wget -O "${target_file}" "${url}"

    if [[ $? -eq 0 && -f "${target_file}" ]]; then
        show_success "${filename}"
    else
        show_error "Couldn't download file to ${target_file}"
    fi
}


URL=$(wl-paste)

if [[ -z "${URL}" ]]; then
    show_error "Clipboard is empty"

    exit 1
fi

if ! [[ "${URL}" =~ ^http ]]; then
    show_error "Not a URL"

    exit 1
fi

if [[ "${URL}" =~ ^https://www.youtube.com ]] || [[ "${URL}" =~ ^https://youtu.be ]]; then
    download_video "${URL}"
elif [[ "${URL}" =~ \.(png|jpg|jpeg|webp|gif|ico|svg)$ ]] || [[ "${URL}" =~ \.(png|jpg|jpeg|webp|gif|ico|svg)? ]]; then
    download_image "${URL}"
else
    download_other "${URL}"
fi

