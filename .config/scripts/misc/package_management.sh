#!/usr/bin/env bash

MODE="${1}"
TERMINAL="kitty"

pakmans=(
    "paru"
    "flatpak"
)

package_manager() {
    pakman=$(printf "%s\n" "${pakmans[@]}" | \
        sort | \
        rofi -dmenu \
        -p "Package manager:" \
        -i \
        -theme-str "window { width: 10%; }" \
        -theme-str "listview { lines: $(printf "%s\n" "${pakmans[@]}" | wc -l); }"
    )
}

install() {
    package_manager

    case "${pakman}" in
        "paru")
            ${TERMINAL} -T "pakman" -e bash -c "paru -Slq | fzf --multi --preview 'paru -Sii --needed {}' --preview-window=down:75%:wrap | xargs -ro paru -S; read -r -p \"Press any key to exit\"" ;;
        "flatpak")
            ${TERMINAL} -T "pakman" -e bash -c "flatpak remote-ls flathub --columns=application,branch |
                awk '!x[\$1]++' |
                fzf --multi --preview 'flatpak remote-info flathub {1}/x86_64/{2}' --preview-window=down:75%:wrap --with-nth 1 |
                awk '{print \$1}' |
                xargs -ro flatpak install -y; read -r -p \"Press any key to exit\"" ;;
        esac
}

deinstall() {
    package_manager

    case "${pakman}" in
        "paru")
            ${TERMINAL} -T "pakman" -e bash -c "paru -Qq | fzf --multi --preview 'paru -Sii {}' --preview-window=down:75%:wrap | xargs -ro paru -Rns; read -r -p \"Press any key to exit\"" ;;
        "flatpak")
            ${TERMINAL} -T "pakman" -e bash -c "flatpak list --app --columns=application | fzf --multi --preview 'flatpak info {}' --preview-window=down:75%:wrap | xargs -ro flatpak uninstall -y; read -r -p \"Press any key to exit\"" ;;
    esac
}

case "${MODE}" in
    "install")
        install ;;
    "deinstall")
        deinstall ;;
    "update")
        ${TERMINAL} -T "pakman" -e bash -c "paru; flatpak update" ;;
esac

