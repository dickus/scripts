#!/bin/bash

if [[ "$#" -ne 3 ]]; then
    echo -e "\033[1m<script> <where_to_search> <hardlink_path> <new_name>\033[0m"
    echo -e "\t\033[1m<where_to_search>\033[0m — the path may be actual or relative. For script to work in current directory you can use dot symbol: \033[1m<script> . <hardlink_path> <new_name>\033[0m"
    echo -e "\t\033[1m<hardlink_path>\033[0m — path to any hardlink which mirrors you need to rename. The path may be actual or relative."
    echo -e "\t\033[1m<new_name>\033[0m — a new name for all hardlinks."
    exit 1
else
    find "$1" -samefile "$2" -exec sh -c 'mv "$0" "$(dirname "$0")/'"$3"'"' {} \;
fi

