### colorpicker.sh
Color picker based on `hyprpicker` but with proper notifications.

### df.sh
Allows me to use `df` with or without `/mnt` directory based on wether it contains anything. Runs with `dfs` specified in `.zshrc`.

### hotkeys_help.sh
A little rofi module to check hyprland keybinds.

### mvhlink.sh
This script renames every hard link related to provided one.

### random.sh
This one takes integer and returns a random number from 1 to integer.

### rofi.sh
This one allows to use different scripts with one keybinding.

### tmux.sh
A script to select tmux layouts.


## fzf
### neofzf_cont.sh
Searches for files content within $HOME and opens them with `neovim`.

### neofzf_name.sh
Searches for files within $HOME and opens them with `neovim`.


## notes
### obsidian.sh
Open todo list.
Open quicknote.
Open notes by name or tag.
Create new notes using templates.
Review notes.

All in one script using rofi.


## run
### resolve.sh
Makes changes in `hyprland.conf` to make sure that popups don't disappear in Davinci Resolve.

### zoom.sh
Runs `Zoom` with null as a XDG_SESSION_TYPE to work properly with screen sharing.


## system
### all_apps.sh
Launcher for all apps.

### apps.sh
Launcher for most used apps.

### creation_time.sh
Gets the time that this installation exists. Runs with `fastfetch` for a custom output.

### dev.sh
Creates a tmux session within a specific project directory.

### garbage.sh
Runs either `Yandex Browser` or `Zoom` with rofi.

### microphone.sh
Un-/mutes default sound source (mic) and sends a notification with `dunst`. Runs with keybindings.

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

### clock.sh
Sets eww clock position to one of 9 presets. Also sets clock position in `hyprlock` screen to one of 8 presets.

### theme_changer.sh
Sets current light/dark theme in `theme_schedule.sh` to chosen ones. Runs with an alias.

### theme_schedule.sh
Changes themes for some tools based on what you've set with `theme`. Runs with `check_time.sh` and doesn't require to edit this script manually.


## wallpapers
### new_wallpaper.sh
Adds a new wallpaper to $HOME/Pictures/wallpapers/ using url. Runs with keybinding, uses `rofi`.

### wall_set.sh
Sets received file as a wallpaper and background for hyprlock.

### wallpaper_selector.sh
Uses `rofi` to select a wallpaper. Manually or randomly.


## yazi
### isomount.sh
Script to mount iso-files in `yazi`.

### isounmount.sh
Script to unmount iso-files in `yazi`.

