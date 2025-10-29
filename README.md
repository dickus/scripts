### open_image_editor
A script to open image editor from `images.sh`.


## audio
### microphone.sh
Un-/mutes default sound source (mic) and sends a notification with `dunst`. Runs with keybindings.

### volume.sh
Manages default sound output and sends a notification with `dunst`. Runs with keybindings.


## daylight
### daylight.sh
A little script to change screen color warmth.


## fzf
### neofzf_cont.sh
Searches for files content within $HOME and opens them with `neovim`.

### neofzf_name.sh
Searches for files within $HOME and opens them with `neovim`.


## launchers
### apps.sh
Launcher for most used apps.

### garbage.sh
Runs either `Yandex Browser` or `Zoom` with rofi.


## misc
### colorpicker.sh
Color picker based on `hyprpicker` but with proper notifications.

### creation_time.sh
Gets the time that this installation exists. Runs with `fastfetch` for a custom output.

### df.sh
Allows me to use `df` with or without `/mnt` directory based on wether it contains anything. Runs with `dfs` specified in `.zshrc`.

### download.sh
A script to download different types of files. Video, images or any other.

### hotkeys_help.sh
A little rofi module to check hyprland keybinds.

### images.sh
A script to manage images in ${HOME}/Pictures directory.

### mvhlink.sh
This script renames every hard link related to provided name.

### package_management.sh
An fzf script to manage packages from repos, AUR and flatpak.

### pkgs.sh
Gets installed packages with pacman, aur and flatpak to show in `fastfetch`.

### process.sh
Process killer with rofi.

### random.sh
This one takes integer and returns a random number from 1 to integer.

### rofi.sh
This one allows to use different scripts with one keybinding.

### screenshoter.sh
Runs with keybindings to make a screenshot of the whole screen, selected window or selected rectangle area, saves new image to $HOME/Pictures and puts it to clipboard. Uses `grim`.

### vpn.sh
Enables/disables `wireguard` VPN with configs from $HOME/.wg. Runs with keybindings, uses `rofi` to pick wg conf or to down connection.


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


## theme_change
### check_time.sh
Sets light or dark theme with `theme_schedule.sh` based on current time. Runs with `fcron` and `theme_changer.sh`.

### theme_changer.sh
Sets current light/dark theme in `theme_schedule.sh` to chosen ones. Runs with an alias.

### theme_schedule.sh
Changes themes for some tools based on what you've set with `theme`. Runs with `check_time.sh` and doesn't require to edit this script manually.


## tmux
### dev.sh
Creates a tmux session within a specific project directory.

### sidedev.sh
Creates a tmux session within a specific project directory. Made to be used along with another window opened.

### tmux.sh
A script to select tmux layouts.


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

