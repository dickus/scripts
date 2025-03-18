#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if ! command -v upower &> /dev/null; then
    echo -e "${RED}Error: upower is not installed${NC}"

    exit 1
fi

readarray -t devices < <(upower -e | grep -iE 'gip|gamepad' | sort -u)

if [[ ${#devices[@]} -eq 0 ]]; then
    echo -e "${YELLOW}No gamepads connected${NC}"

    exit 0
fi

for ((i=0; i<${#devices[@]}; i++)); do
    device="${devices[$i]}"

    model=$(upower -i "$device" | awk -F': ' '/model/ {gsub(/^[ \t]+/, "", $2); print $2}')
    percent=$(upower -i "$device" | grep -Po 'percentage:\s*\K\d+')
    device_id=$(grep -Po 'gip[\dXx]+' <<< "$device")

    if [[ $i -ne $((${#devices[@]} -1)) ]]; then
        sep=$'\n'
    else
        sep=""
    fi

    echo -e "${BLUE}=== Device $((i+1))/${#devices[@]} ===${NC}"
    echo -e "${GREEN}ID:${NC}\t\t$device_id"
    echo -e "${GREEN}Name:${NC}\t\t${model:-Unknown}"

    if [[ -n "$percent" ]]; then
        if [[ $percent -ge 50 ]]; then
            color=$GREEN
        elif [[ $percent -ge 20 ]]; then
            color=$YELLOW
        else
            color=$RED
        fi

        echo -e "${GREEN}Battery:${NC}\t${color}${percent}%${NC}"
    else
        echo -e "${GREEN}Battery:${NC}\t${RED}N/A${NC}${sep}"
    fi
done
