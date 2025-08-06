#!/bin/bash

app=$(echo -e "qBittorrent\nTelegram\nDiscord\nGIMP\nDaVinci Resolve\nAudacity\nSteam\nBattle.net" | \
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
elif [[ "${app}" == "Telegram" ]]; then
    org.telegram.desktop
elif [[ "${app}" == "Discord" ]]; then
    dev.vencord.Vesktop
elif [[ "${app}" == "GIMP" ]]; then
    org.gimp.GIMP
elif [[ "${app}" == "DaVinci Resolve" ]]; then
    ${HOME}/.config/scripts/run/resolve.sh
elif [[ "${app}" == "Audacity" ]]; then
    ${HOME}/.config/waybar/runners/audacity.sh
elif [[ "${app}" == "Steam" ]]; then
    mangohud steam -console
elif [[ "${app}" == "Battle.net" ]]; then
    env "$HOME/PortProton/data/scripts/start.sh" "$HOME/PortProton/data/prefixes/BATTLE_NET/drive_c/Program Files (x86)/Battle.net/Battle.net.exe"
fi

