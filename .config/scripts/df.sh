#!/bin/bash

sdc=$(lsblk | grep "sdc")

if [[ -z "$sdc" ]]; then
    df -h / /home
else
    df -h / /home /mnt
fi

