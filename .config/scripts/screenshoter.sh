#!/bin/bash

arg=$1
f="screen_$(date +%F_%H%M%S)".png

case "$arg" in
    screen)
        import -window root ~/Pictures/"$f" && xclip -sel clip -t image/png -i ~/Pictures/"$f" ;;

    region)
        import ~/Pictures/"$f" && xclip -sel clip -t image/png -i ~/Pictures/"$f" ;;
esac

dunstify -t 2000 -i $HOME/Pictures/"$f" "Screenshot saved" "$f"

