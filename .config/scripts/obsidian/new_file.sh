#!/bin/bash

if [[ -z "$1" ]]; then
    echo -e '\033[1mon "<file_name>"'

    exit 1
fi

file_name=$(echo "$1" | tr ' ' '-')
formatted_file_name=$(date "+%Y-%m-%d")_${file_name}
docs_path="$HOME/.docs"
templates_directory="templates"
drafts_directory="drafts"

cd "$HOME" || exit
touch "${docs_path}/${drafts_directory}/${formatted_file_name}".md

cat "${docs_path}/${templates_directory}/note.md" > "${docs_path}/${drafts_directory}/${formatted_file_name}".md

sed -i "s|{{id}}|${formatted_file_name}|" "${docs_path}/${drafts_directory}/${formatted_file_name}".md
sed -i "s|{{title}}|${file_name}|" "${docs_path}/${drafts_directory}/${formatted_file_name}".md

cd "${docs_path}"
nvim "${drafts_directory}/${formatted_file_name}".md

