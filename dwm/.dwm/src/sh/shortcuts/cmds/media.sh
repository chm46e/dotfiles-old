#!/bin/sh

if [[ $1 == "next" ]]; then
    ~/.dwm/src/sh/shortcuts/cmds/mediactl Next
elif [[ $1 == "last" ]]; then
    ~/.dwm/src/sh/shortcuts/cmds/mediactl Previous
elif [[ $1 == "toggle" ]]; then
    ~/.dwm/src/sh/shortcuts/cmds/mediactl PlayPause
fi
