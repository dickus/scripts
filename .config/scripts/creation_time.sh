#!/bin/bash

CREATION_DATE=$(stat -c %W /)
CURRENT_TIME=$(date +%s)
TIME_SINCE_CREATED=$(($CURRENT_TIME - $CREATION_DATE))
days=$(($TIME_SINCE_CREATED / 86400))
hours=$((($TIME_SINCE_CREATED % 86400) / 3600))
minutes=$((($TIME_SINCE_CREATED % 3600) / 60))

echo "${days}d ${hours}h ${minutes}m"

