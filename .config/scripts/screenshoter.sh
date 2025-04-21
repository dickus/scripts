#!/bin/bash

FILE="screen_$(date +%F_%H%M%S)".png

case "$1" in
    screen)
        import -window root ~/Pictures/"$FILE" && xclip -sel clip -t image/png -i ~/Pictures/"$FILE" ;;

    region)
        import ~/Pictures/"$FILE" && xclip -sel clip -t image/png -i ~/Pictures/"$FILE" ;;
esac

dunstify -t 2000 -i $HOME/Pictures/"$FILE" "Screenshot saved" "$FILE"

