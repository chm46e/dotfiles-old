#!/bin/sh

webl_d=~/.dwm/src/sh/rofi/webl
sellink=$(rofi -dmenu -i -p "  " -no-custom -config $webl_d/webl.rasi -input $webl_d/links)

if [[ -z $sellink ]]; then
    exit 1
fi

sleep 0.5
librewolf $sellink
