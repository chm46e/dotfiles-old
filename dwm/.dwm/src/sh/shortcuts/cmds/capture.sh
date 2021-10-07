#!/bin/bash

if [[ $1 == "up" ]]; then
    amixer -q set Capture 5%+ unmute
elif [[ $1 == "down" ]]; then
    amixer -q set Capture 5%- unmute
elif [[ $1 == "toggle" ]]; then
    amixer -q set Capture toggle
fi
