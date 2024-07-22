#!/bin/bash

INFO=$(upower -e | grep "gip")
ITEMS=$(echo "$INFO" | wc -l)
CURRENT_ITEM=1

if [ "$INFO" ]; then
    for item in $INFO; do
        DEVICE_ID=$(echo $item | grep -o "gip[0-9]x[0-9]")
        MODEL=$(upower -i $item | grep "model")
        MODEL=$(echo $MODEL | sed "s/model://")
        DEVICE_NAME=$(echo $MODEL | grep -P "^[^\s]")
        PERCENT=$(upower -i $item | grep -Eow "[0-9]{2,3}%")
        LOW_PERCENT=$(echo "$PERCENT" | awk '{print int($1)}')
    
        echo -e "\033[1mid:\033[0m \t${DEVICE_ID}"
        echo -e "\033[1mName:\033[0m \t${DEVICE_NAME}"

        if [ $LOW_PERCENT -ge 50 ]; then
            if [ "$CURRENT_ITEM" -lt "$ITEMS" ]; then
                echo -e "\033[1mCharge:\033[0m ${PERCENT}\n"
            else
                echo -e "\033[1mCharge:\033[0m ${PERCENT}"
            fi
        else
            if [ "$CURRENT_ITEM" -lt "$ITEMS" ]; then
                echo -e "\033[1mCharge:\033[0m \033[0;31m${PERCENT}\033[0m\n"
            else
                echo -e "\033[1mCharge:\033[0m \033[0;31m${PERCENT}\033[0m"
            fi
        fi

        CURRENT_ITEM=$((CURRENT_ITEM + 1))
    done
else
    echo -e "No gamepad connected."
fi

