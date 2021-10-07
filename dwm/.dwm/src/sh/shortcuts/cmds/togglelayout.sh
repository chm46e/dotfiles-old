#!/bin/bash

KEYMAP=$(setxkbmap -v | awk -F "+" '/symbols/ {print $2}')

if [[ $KEYMAP == "us" ]]; then
    setxkbmap ee
elif [[ $KEYMAP == "ee" ]]; then
    setxkbmap us
else
    setxkbmap us
fi
