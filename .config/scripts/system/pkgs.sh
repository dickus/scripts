#!/bin/bash

PACMAN=$(pacman -Qn | wc -l)
AUR=$(pacman -Qm | wc -l)
FLATPAK=$(flatpak list --app | wc -l)

echo "${PACMAN} (pacman), ${AUR} (aur), ${FLATPAK} (flatpak)"

