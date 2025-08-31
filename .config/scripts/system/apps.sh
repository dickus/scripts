#!/usr/bin/env bash

app=$(echo -e "qBittorrent\nCommunication\nGIMP\nDaVinci Resolve\nAudacity\nSteam\nWorld of Warcraft" | \
    sort | \
    rofi -dmenu \
    -p "App:" \
    -i \
    -theme-str "window { width: 17%; }" \
    -theme-str "listview { lines: 4; columns: 2; }"
)

[[ -z "${app}" ]] && exit 0

if [[ "${app}" == "qBittorrent" ]]; then
    org.qbittorrent.qBittorrent
elif [[ "${app}" == "Communication" ]]; then
    org.telegram.desktop &

    dev.vencord.Vesktop &
elif [[ "${app}" == "GIMP" ]]; then
    org.gimp.GIMP
elif [[ "${app}" == "DaVinci Resolve" ]]; then
    ${HOME}/.config/scripts/run/resolve.sh
elif [[ "${app}" == "Audacity" ]]; then
    ${HOME}/.config/waybar/runners/audacity.sh
elif [[ "${app}" == "Steam" ]]; then
    mangohud steam -console
elif [[ "${app}" == "World of Warcraft" ]]; then
    env LUTRIS_SKIP_INIT=1 lutris lutris:rungameid/1 &

    wowup-cf

    env "${HOME}/PortProton/data/scripts/start.sh" "${HOME}/PortProton/data/prefixes/BATTLE_NET/drive_c/Program Files (x86)/Battle.net/Battle.net.exe"
fi

