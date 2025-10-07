#!/usr/bin/env bash

SDC=$(lsblk | grep "sdc")

if [[ -z "${SDC}" ]]; then
    df -h / /home
else
    df -h / /home ${HOME}/mnt
fi

