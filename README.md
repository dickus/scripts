### apps.sh
Launcher for most used apps.

### colorpicker.sh
Color picker based on `hyprpicker` but with proper notifications.

### df.sh
Allows me to use `df` with or without `/mnt` directory based on wether it contains anything. Runs with `dfs` specified in `.zshrc`.

### mvhlink.sh
This script renames every hard link related to provided one.

### random.sh
This one takes integer and returns a random number from 1 to integer.

### rofi.sh
This one allows to use different scripts with one keybinding.


## fzf
### neofzf_cont.sh
Searches for files content within $HOME and opens them with `neovim`.

### neofzf_name.sh
Searches for files within $HOME and opens them with `neovim`.


## notes
### obsidian.sh
Open notes by name or tag.
Open drafts by name or tag.
Create new notes using templates.
Review notes.

All in one script using rofi.


## run
### resolve.sh
Makes changes in `hyprland.conf` to make sure that popups don't disappear in Davinci Resolve.


## system
### creation_time.sh
Gets the time that this installation exists. Runs with `fastfetch` for a custom output.

### microphone.sh
Un-/mutes default sound source (mic) and sends a notification with `dunst`. Runs with keybindings.

### new_wallpaper.sh
Adds a new wallpaper to $HOME/Pictures/wallpapers/ using url. Runs with keybinding, uses `rofi`.

### pkgs.sh
Gets installed packages with pacman, aur and flatpak to show in `fastfetch`.

### process.sh
Process killer with rofi.

### screenshoter.sh
Runs with keybindings to make a screenshot of the whole screen, selected window or selected rectangle area, saves new image to $HOME/Pictures and puts it to clipboard. Uses `grim`.

### volume.sh
Manages default sound output and sends a notification with `dunst`. Runs with keybindings.

### vpn.sh
Enables/disables `wireguard` VPN with configs from $HOME/.wg. Runs with keybindings, uses `rofi` to pick wg conf or to down connection.

### yt.sh
Script to download videos from YouTube using `yt-dlp`.


## theme_change
### check_time.sh
Sets light or dark theme with `theme_schedule.sh` based on current time. Runs with `fcron` and `theme_changer.sh`.

### theme_changer.sh
Sets current light/dark theme in `theme_schedule.sh` to chosen ones. Runs with an alias.

### theme_schedule.sh
Changes themes for some tools based on what you've set with `theme`. Runs with `check_time.sh` and doesn't require to edit this script manually.


## wallpapers
### wall_set.sh
Sets received file as a wallpaper and background for hyprlock.

### wallpaper_selector.sh
Uses `rofi` to select a wallpaper. Manually or randomly.


## yazi
### isomount.sh
Script to mount iso-files in `yazi`.

### isounmount.sh
Script to unmount iso-files in `yazi`.

