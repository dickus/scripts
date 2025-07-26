### df.sh
Allows me to use `df` with or without `/mnt` directory based on wether it contains anything. Runs with `dfs` specified in `.zshrc`.

### mvhlink.sh
This script renames every hard link related to provided one.

### random.sh
This one takes integer and returns a random number from 1 to integer.

### rofi.sh
This one allows to use different scripts from `rofi_scripts` directory with one keybinding.


## fzf
### neofzf_cont.sh
Searches for files content within $HOME and opens them with `neovim`.

### neofzf_name.sh
Searches for files within $HOME and opens them with `neovim`.


## rofi_scripts
### new_note.sh
Creates a file in $HOME/.docs catalog with a date and chosen text as its name, and opens this file with `neovim`.

I use this with my obsidian.nvim workflow.

Runs with a keybinding as it uses `rofi`.

### new_wallpaper.sh
Adds a new wallpaper to $HOME/Pictures/wallpapers/[dark|light] using url. Runs with keybinding, uses `rofi`.

### vpn.sh
Enables/disables `wireguard` VPN with configs from $HOME/.wg. Runs with keybindings, uses `rofi` to pick wg conf or to down connection.


## run
### resolve.sh
Makes changes in `hyprland.conf` to make sure that popups don't disappear in Davinci Resolve.


## system
### creation_time.sh
Gets the time that this installation exists. Runs with `fastfetch` for a custom output.

### microphone.sh
Un-/mutes default sound source (mic) and sends a notification with `dunst`. Runs with keybindings.

### pkgs.sh
Gets installed packages with pacman, aur and flatpak to show in `fastfetch`.

### screenshoter.sh
Runs with keybindings to make a screenshot of the whole screen, selected window or selected rectangle area, saves new image to $HOME/Pictures and puts it to clipboard. Uses `imagemagick` on x11 and `grim` on wayland.

### volume.sh
Manages default sound output and sends a notification with `dunst`. Runs with keybindings.


## theme_change
### check_time.sh
Sets light or dark theme with `theme_schedule.sh` based on current time. Runs with `fcron` and `theme_changer.sh`.

### theme_changer.sh
Sets current light/dark theme in `theme_schedule.sh` to chosen ones. Runs with an alias.

### theme_schedule.sh
Changes themes for some tools based on what you've set with `theme`. Runs with `check_time.sh` and doesn't require to edit this script manually.


## wallpapers
### wallpaper_changer.sh
Changes wallpapers to a random image from $HOME/Pictures/wallpapers[dark|light] depending on time of day. Runs with `fcron` on x11 and `wayland_wrapper.sh` on wayland. Uses `feh` on x11 and `swww` on wayland.

### wayland_wrapper.sh
Sets some variables for `swww` to work properly. Runs with `fcron`.

### wrapper.sh
Script that is required for `wallpaper_changer.sh` to work properly in wayland.


## yazi
### isomount.sh
Script to mount iso-files in `yazi`.

### isounmount.sh
Script to unmount iso-files in `yazi`.

