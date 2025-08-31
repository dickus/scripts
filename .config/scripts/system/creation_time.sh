#!/usr/bin/env bash

CREATION_DATE=$(stat -c %W /)
CURRENT_TIME=$(date +%s)
TIME_SINCE_CREATED=$((${CURRENT_TIME} - ${CREATION_DATE}))

DAYS=$((${TIME_SINCE_CREATED} / 86400))
HOURS=$(((${TIME_SINCE_CREATED} % 86400) / 3600))

if [[ -f "${HOME}/.config/scripts/fuck" ]]; then
    INCIDENT_DATE=$(stat -c %W "${HOME}/.config/scripts/fuck")
    TIME_WITHOUT_INCIDENT=$((${CURRENT_TIME} - ${INCIDENT_DATE}))
else
    TIME_WITHOUT_INCIDENT=$((${CURRENT_TIME} - ${CREATION_DATE}))
fi

DAYS_WITHOUT_INCIDENT=$((${TIME_WITHOUT_INCIDENT} / 86400))

result=""
[[ ${DAYS} -gt 0 ]] && result="${result}${result:+ }${DAYS}d"
[[ ${HOURS} -gt 0 ]] && result="${result}${result:+ }${HOURS}h"
result="${result}${result:+}, days without incidents: ${DAYS_WITHOUT_INCIDENT}"

echo "${result}"

