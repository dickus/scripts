#!/usr/bin/env bash

MODE=""
TERMINAL="kitty"

pakmans=(
    "yay"
    "flatpak"
)

actions=(
    "install"
    "remove"
    "update"
)

choose_action() {
    action=$(
        printf "%s\n" "${actions[@]}" | \
        rofi -dmenu \
            -p "Choose action:" \
            -i \
            -theme-str "window { width: 10%; }" \
            -theme-str "listview { lines: $( \
                printf "%s\n" "${actions[@]}" | \
                wc -l
            ); }"
        )

    MODE=${action}
}

choose_package_manager() {
    pakman=$(
        printf "%s\n" "${pakmans[@]}" | \
        sort | \
        rofi -dmenu \
            -p "Package manager:" \
            -i \
            -theme-str "window { width: 10%; }" \
            -theme-str "listview { lines: $( \
                printf "%s\n" "${pakmans[@]}" | \
                wc -l
            ); }"
    )
}

install() {
    choose_package_manager

    case "${pakman}" in
        "yay")
            ${TERMINAL} -T "pakman" -e bash -c '
            mapfile -t pkgs < <(
                yay -Slq |
                fzf --multi --preview "yay -Sii --needed {}" --preview-window=down:75%:wrap
            )
            if (( ${#pkgs[@]} )); then
                yay -S "${pkgs[@]}"
                read -r -p "Press Enter to exit"
            fi
            ' ;;
        "flatpak")
            ${TERMINAL} -T "pakman" -e bash -c '
            mapfile -t pkgs < <(
                flatpak remote-ls flathub --columns=application,branch |
                awk "!x[\$1]++" |
                fzf --multi --preview "flatpak remote-info flathub {1}/x86_64/{2}" --preview-window=down:75%:wrap --with-nth 1 |
                awk "{print \$1}"
            )
            if (( ${#pkgs[@]} )); then
                flatpak install -y "${pkgs[@]}"
                read -r -p "Press Enter to exit"
            fi
            ' ;;
    esac
}

remove() {
    choose_package_manager

    case "${pakman}" in
        "yay")
            ${TERMINAL} -T "pakman" -e bash -c '
            mapfile -t pkgs < <(
                yay -Qq |
                fzf --multi --preview "yay -Sii {}" --preview-window=down:75%:wrap
            )
            if (( ${#pkgs[@]} )); then
                yay -Rns "${pkgs[@]}"
                read -r -p "Press Enter to exit"
            fi
            ' ;;
        "flatpak")
            ${TERMINAL} -T "pakman" -e bash -c '
            mapfile -t pkgs < <(
                flatpak list --app --columns=application |
                fzf --multi --preview "flatpak info {}" --preview-window=down:75%:wrap
            )
            if (( ${#pkgs[@]} )); then
                flatpak uninstall -y "${pkgs[@]}"
                read -r -p "Press Enter to exit"
            fi
            ' ;;
    esac
}

update() {
    ${TERMINAL} -T "pakman" -e bash -c "yay -Syu; flatpak update"
}

choose_action

case "${MODE}" in
    "install")
        install ;;
    "remove")
        remove ;;
    "update")
        update ;;
esac

