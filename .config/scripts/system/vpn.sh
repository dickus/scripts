#!/bin/bash

CONNECTION=$(ifconfig | grep "vpn")

if [[ -z "$CONNECTION" ]]; then
    wg-quick up .wg/vpn.conf

    CONNECTION=$(ifconfig | grep "vpn")

    if [[ -z "$CONNECTION" ]]; then
        dunstify -t 2000 -i $HOME/.icons/dark/connection_down.svg "VPN" "Connection error"
    else
        dunstify -t 1500 -i $HOME/.icons/dark/connection_up.svg "VPN" "Connection up"
    fi
else
    wg-quick down .wg/vpn.conf

    dunstify -t 1500 -i $HOME/.icons/dark/connection_down.svg "VPN" "Connection down"
fi

