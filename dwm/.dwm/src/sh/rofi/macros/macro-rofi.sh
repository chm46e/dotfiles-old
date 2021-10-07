#!/bin/sh

macro_d=~/.dwm/src/sh/rofi/macros
selmacro=$(rofi -dmenu -i -p " 🗲 " -no-custom -config $macro_d/macro.rasi -input $macro_d/macros)

if [[ -z $selmacro ]]; then
    exit 1
fi

sleep 0.5
xdotool type $selmacro
