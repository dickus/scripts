#!/bin/bash

apps=$(rofi -show drun \
    -theme-str "window { width: 20%; }" \
    -theme-str "lineview { columns: 1; }"
)

