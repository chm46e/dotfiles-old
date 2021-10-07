#!/bin/sh

readonly _RASI=~/.dwm/src/sh/rofi/bt/rasi
readonly _OFF_R=$_RASI/bt_off.rasi
readonly _ON_R=$_RASI/bt_on.rasi
readonly _QFIX=~/.dwm/src/sh/rofi/bt/quickfix.sh

readonly _SP="-------------------------------------------------------"

readonly __powererr="[ERROR] Failed to toggle power\nGive Up (cold-reboot)\nTry Quickfix"
readonly __pairerr="[ERROR] Failed to toggle pairable\nGive Up (cold-reboot)\nTry Quickfix"
readonly __scanerr="[ERROR] Failed to scan\nGive Up (cold-reboot)\nTry Quickfix"
readonly __devpairerr="[ERROR] Failed to pair with device\nGive Up (cold-reboot)\nTry Quickfix"
readonly __devdiscerr="[ERROR] Failed to disconnect device\nGive Up (cold-reboot)\nTry Quickfix"


launch()
{
    case $3 in
        enabled) option=$(echo -e "$1" | rofi -dmenu -i -p "  " -no-custom -config $2) ;;
        disabled) option=$(echo -e "$1" | rofi -dmenu -i -p "  " -no-custom -config $2) ;;
        error) option=$(echo -e "$1" | rofi -dmenu -i -p "  " -no-custom -config $2) ;;
        *) option=$(echo -e "$1" | rofi -dmenu -i -p "$3" -no-custom -config $2) ;;
    esac
    [ -z "$option" ] && exit 1
}

toggle_bt()
{
    local try=""
    [ $1 == 1 ] && try=$(bluetoothctl power on)
    [ $1 == 0 ] && try=$(bluetoothctl power off)

    manage_err "$try" "$__powererr"
    main
}

toggle_pair()
{
    local try=""
    [ $1 == 1 ] && try=$(bluetoothctl pairable on)
    [ $1 == 0 ] && try=$(bluetoothctl pairable off)

    manage_err "$try" "$__pairerr"
    main
}

quickfix()
{
    kitty $_QFIX
    main
}

chklist()
{
    config=$_ON_R
    state_power=$(bluetoothctl show | grep Powered | grep yes)
    [ -z "$state_power" ] && state_power="disabled" && config=$_OFF_R || state_power="enabled"

    state_pair=$(bluetoothctl show | grep Pairable | grep yes)
    [ -z "$state_pair" ] && state_pair=0 && config=$_OFF_R || state_pair=1

    state_discv=$(bluetoothctl show | grep Discovering | grep yes)
    [ -z "$state_discv" ] && state_discv=0 || state_discv=1
}

manage_err()
{
    if [ "$(echo $1 | grep Error)" != "" ]; then
        launch "$2" $_OFF_R "error"
        case $option in
            "Give Up (cold-reboot)") poweroff ;;
            "Try Quickfix") quickfix ;;
            *) main ;;
        esac
    fi
}

connect_w()
{
    if [ $1 == 1 ]; then
        local try=$(bluetoothctl connect $dev)

        if [ "$(echo -e $try | grep not)" != "" ]; then
            local try_pair=$(bluetoothctl pair $dev | grep successful)
            if [ -z "$try_pair" ]; then
                launch "$__devpairerr" $_OFF_R "error"
                case $option in
                    "Give Up (cold-reboot)") poweroff ;;
                    "Try Quickfix") quickfix ;;
                    *) main ;;
                esac
            fi
        fi
    elif [ $1 == 0 ]; then
        local try=$(bluetoothctl disconnect $dev)

        if [ -z "$(echo -e $try | grep Successful)" ]; then
            if [ -z "$try" ]; then
                launch "$__devdiscerr" $_OFF_R "error"
                case $option in
                    "Give Up (cold-reboot)") poweroff ;;
                    "Try Quickfix") quickfix ;;
                    *) main ;;
                esac
            fi
        fi
    fi

    main
}

unpair()
{
    bluetoothctl remove $dev
    main
}

con_w()
{
    dev="$option"
    config=$_OFF_R

    local dev_name="$(bluetoothctl info $dev | grep Name | cut -d ' ' -f 2-10)"
    [ -z "$dev_name" ] && dev_name="$dev"

    local dev_conn="$(bluetoothctl info $dev | grep Connected | grep yes)"
    [ -z "$dev_conn" ] && dev_conn="Connect\n" || (dev_conn="Disconnect\n" && config=$_ON_R)

    local dev_pair="$(bluetoothctl info $dev | grep Paired | grep no)"
    [ -z "$dev_pair" ] && dev_pair="Unpair\n" || dev_pair=""

    local info="$dev_conn$dev_pair"
    launch "$info" $config "$dev_name"

    case $option in
        "Connect") connect_w 1 ;;
        "Disconnect") connect_w 0 ;;
        "Unpair") unpair ;;
    esac

}

master_w()
{
    local master_w="Refresh"

    case $state_power in
        disabled) master_w="$master_w\nTurn Bluetooth on" ;;
        enabled) master_w="$master_w\nTurn Bluetooth off" ;;
    esac

    case $state_pair in
        0) master_w="$master_w\nTurn Pairable on\n$_SP\n" ;;
        1) master_w="$master_w\nTurn Pairable off\n$_SP\n" ;;
    esac

    local macs=""
    if [[ $state_power == "enabled" && $state_pair == "1" && "$1" == "refresh" ]]; then
        local devs="$(bluetoothctl --timeout 5 scan on | grep Device)"
        manage_err "$devs" "$__scanerr"
        macs="$(echo -e $devs | cut -d ' ' -f 3)"
    fi

    launch "$master_w$macs" $config $state_power

    case $option in
        "Refresh") main "refresh" ;;
        "Turn Bluetooth on") toggle_bt 1 ;;
        "Turn Bluetooth off") toggle_bt 0 ;;
        "Turn Pairable on") toggle_pair 1 ;;
        "Turn Pairable off") toggle_pair 0 ;;
        "$_SP") main ;;
        *) con_w ;;
    esac
}

main()
{
    chklist
    master_w "$1"
}

main "refresh"
