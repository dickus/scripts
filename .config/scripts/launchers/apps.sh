#!/usr/bin/env bash

apps=(
    "qBittorrent"
    "Communication"
    "GIMP"
    "DaVinci Resolve"
    "Audacity"
    "Steam"
    "World of Warcraft"
    "Minecraft"
)

app=$(printf "%s\n" "${apps[@]}" | \
    sort | \
    rofi -dmenu \
    -p "App:" \
    -i \
    -theme-str "window { width: 18%; }" \
    -theme-str "listview { lines: 4; columns: 2; }"
)

[[ -z "${app}" ]] && exit 0

case "${app}" in
    "qBittorrent")
        org.qbittorrent.qBittorrent & ;;
    "Communication")
        org.telegram.desktop &

        dev.vencord.Vesktop & ;;
    "GIMP")
        org.gimp.GIMP & ;;
    "DaVinci Resolve")
        ${HOME}/.config/scripts/run/resolve.sh & ;;
    "Audacity")
        ${HOME}/.config/waybar/runners/audacity.sh & ;;
    "Steam")
        mangohud steam -console ;;
    "World of Warcraft")
        env LUTRIS_SKIP_INIT=1 lutris lutris:rungameid/1 &

        wowup-cf

        env "${HOME}/PortProton/data/scripts/start.sh" "${HOME}/PortProton/data/prefixes/BATTLE_NET/drive_c/Program Files (x86)/Battle.net/Battle.net.exe" & ;;
    "Minecraft")
        org.prismlauncher.PrismLauncher & ;;
esac

