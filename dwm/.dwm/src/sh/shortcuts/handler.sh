#!/bin/sh

CMDS=~/.dwm/src/sh/shortcuts/cmds
ROFI=~/.dwm/src/sh/rofi

case $1 in
    rofi) rofi -show drun -config $ROFI/config.rasi &;;
    webl) $ROFI/webl/webl-rofi.sh &;;
    macro) $ROFI/macros/macro-rofi.sh &;;
    wifi) $ROFI/wifi/wifi-rofi.sh &;;
    bt) $ROFI/bt/bt-rofi.sh &;;

    term) st fish &;;
    atom) st nvim &;;
    filem) nautilus &;;
    discord) Discord &;;
    htop) st glances &;;

    fsgui) flameshot gui --path ~/Pictures/Flameshot &;;
    fsfull) flameshot full --path ~/Pictures/Flameshot &;;

    browser) librewolf &;;
    altbrowser) firefox &;;

    chlayout) $CMDS/togglelayout.sh &;;

    voli) $CMDS/volume.sh up &;;
    vold) $CMDS/volume.sh down &;;
    volmute) $CMDS/volume.sh toggle &;;

    mici) $CMDS/capture.sh up &;;
    micd) $CMDS/capture.sh down &;;
    micmute) $CMDS/capture.sh toggle &;;

    bri) light -A 5 &;;
    brd) light -U 5 &;;

    mnext) $CMDS/media.sh next &;;
    mlast) $CMDS/media.sh last &;;
    mtoggle) $CMDS/media.sh toggle &;;
esac
