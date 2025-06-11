#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: only one argument required." >&2

    exit 1
fi

if ! [[ $1 =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: argument must be int." >&2

    exit 1
fi

RANDOM_NUMBER=$((1 + RANDOM % $1))
echo $RANDOM_NUMBER

