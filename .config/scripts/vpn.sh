#!/bin/bash

connection=$(ifconfig | grep "vpn")

if [[ -z "$connection" ]]; then
    wg-quick up .wg/vpn.conf

    connection=$(ifconfig | grep "vpn")

    if [[ -z "$connection" ]]; then
        dunstify -t 2000 -i $HOME/.icons/light/connection_down.svg "VPN" "Connection error"
    else
        dunstify -t 1500 -i $HOME/.icons/light/connection_up.svg "VPN" "Connection up"
    fi
else
    wg-quick down .wg/vpn.conf

    dunstify -t 1500 -i $HOME/.icons/light/connection_down.svg "VPN" "Connection down"
fi

