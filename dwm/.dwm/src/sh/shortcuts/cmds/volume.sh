#!/bin/bash

# Idk about this
#mpg123 /home/wolfy/.config/dwm-6.2/data/dog.mp3

if [[ $1 == "up" ]]; then
    amixer -q set Master 5%+ unmute
elif [[ $1 == "down" ]]; then
    amixer -q set Master 5%- unmute
elif [[ $1 == "toggle" ]]; then
    amixer -q set Master toggle
fi
