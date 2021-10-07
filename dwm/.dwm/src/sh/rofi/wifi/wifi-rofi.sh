#!/bin/sh

readonly _RASI=~/.dwm/src/sh/rofi/wifi/rasi
readonly _OFF_R=$_RASI/wifi_off.rasi
readonly _ON_R=$_RASI/wifi_on.rasi
readonly _PASSWD_R=$_RASI/wifi_passwd.rasi

readonly _SP="-------------------------------------------------------\n"
readonly _SPA="-------------------------------------------------------"

readonly __nmerror="[ERROR] NetworkManager is not running!\nStart it by running:\nsudo systemctl start NetworkManager"
readonly __offmaster_w="Refresh\nTurn wifi off\n$_SP"
readonly __onmaster_w="Refresh\nTurn wifi on\n$_SP"
readonly __conoff_w="Connect\n$_SP"
readonly __conon_w="Disconnect\n$_SP"
readonly __cerror="[ERROR] Failed to connect"
readonly __dcerror="[ERROR] Failed to disconnect"
readonly __inverror="[ERROR] Invalid password"

launch()
{
    case $3 in
        enabled) option=$(echo -e "$1" | rofi -dmenu -i -p "  " -no-custom -config $2) ;;
        disabled) option=$(echo -e "$1" | rofi -dmenu -i -p "  " -no-custom -config $2) ;;
        wired) option=$(echo -e "$1" | rofi -dmenu -i -p "  " -no-custom -config $2) ;;
        error) option=$(echo -e "$1" | rofi -dmenu -i -p "  " -no-custom -config $2) ;;
        password) option=$(echo -e "$1" | rofi -dmenu -i -p " Password: " -password -config $2) ;;
        *) option=$(echo -e "$1" | rofi -dmenu -i -p $3 -no-custom -config $2) ;;
    esac
    [ -z "$option" ] && exit 1
}

togglewifi()
{
    if [ "$STATE_WIFI" == "enabled" ]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
}

chklist()
{
    # Check if NetworkManager is running #
    local state_nm=$(nmcli -t -f RUNNING general)

    if [ "$state_nm" != "running" ]; then
        echo -e $__nmerror
        launch $__nmerror $_OFF_R "error"
        exit 1
    fi

    # Check if Wifi is enabled #
    cons_SSID=()
    CONFIG=$_OFF_R
    STATE_WIFI=$(nmcli radio wifi)

    if [ $STATE_WIFI == "enabled" ]; then
        cons_SSID=$(nmcli -g ssid dev wifi list)
        CONFIG=$_ON_R
    fi
}

passwd_w()
{
    launch "" $_PASSWD_R "password"

    local trypass=$(nmcli dev wifi connect $SSID password "$option")
    if [ -z "$(echo $trypass | grep successfully)" ]; then
        launch "$__inverror" $_OFF_R "error"
    fi
}

connect_w()
{
    if [ $1 == 1 ]; then
        try=$(nmcli con up $SSID)
        if [[ "$(echo $try | grep Passwords)" != "" || -z "$try" ]]; then
            passwd_w
        elif [ -z "$(echo $try | grep successfully)" ]; then
            launch "$__cerror" $_OFF_R "error"
        fi
    elif [ $1 == 0 ]; then
        try=$(nmcli con down $SSID)
        if [ -z "$(echo $try | grep successfully)" ]; then
            launch "$__dcerror" $_OFF_R "error"
        fi
    fi
    main

}

con_w()
{
    local SSID=$option
    local state_ssid=$(nmcli con show --active | grep $SSID)
    [ "$state_ssid" != "" ] && state_ssid=1 || state_ssid=0

    local show_type=$(nmcli -g connection.type con show $SSID)
    local show_if=$(nmcli -g connection.interface-name con show $SSID)
    local show_ac=$(nmcli -g connection.autoconnect con show $SSID)
    local show_ipv4=$(nmcli -g IP4.ADDRESS con show $SSID)
    local show_dns=$(nmcli -g IP4.DNS con show $SSID)
    local show_gw=$(nmcli -g IP4.GATEWAY con show $SSID)

    [ -v $show_type ] && show_type="unknown"
    [ -v $show_if ] && show_if="unknown"
    [ -v $show_ac ] && show_ac="unknown"
    [ -v $show_ipv4 ] && show_ipv4="unknown"
    [ -v $show_dns ] && show_dns="unknown"
    [ -v $show_gw ] && show_gw="unknown"

    local info="Type: $show_type\nInterface: $show_if\nAC: $show_ac\nIPv4: $show_ipv4\nDNS: $show_dns\nGateway: $show_gw"

    case $state_ssid in
        0) launch "$__conoff_w$info" $_OFF_R $SSID ;;
        1) launch "$__conon_w$info" $_ON_R $SSID ;;
    esac

    case $option in
        "Connect") connect_w 1 ;;
        "Disconnect") connect_w 0 ;;
        *) main ;;
    esac
}

showwired_w()
{
    local wired="$(nmcli -g name con show --active | grep Wired)"
    launch "$wired" $_ON_R "wired"

    local show_type=$(nmcli -g connection.type con show "$option")
    local show_if=$(nmcli -g connection.interface-name con show "$option")
    local show_ac=$(nmcli -g connection.autoconnect con show "$option")
    local show_ipv4=$(nmcli -g IP4.ADDRESS con show "$option")
    local show_dns=$(nmcli -g IP4.DNS con show "$option")
    local show_gw=$(nmcli -g IP4.GATEWAY con show "$option")

    [ -v "$show_type" ] && show_type="unknown"
    [ -v "$show_if" ] && show_if="unknown"
    [ -v "$show_ac" ] && show_ac="unknown"
    [ -v "$show_ipv4" ] && show_ipv4="unknown"
    [ -v "$show_dns" ] && show_dns="unknown"
    [ -v "$show_gw" ] && show_gw="unknown"

    local info="Type: $show_type\nInterface: $show_if\nAC: $show_ac\nIPv4: $show_ipv4\nDNS: $show_dns\nGateway: $show_gw"
    launch "$info" $_ON_R "$option"

    main
}

showmaster_w()
{
    local wired=""
    if [ "$(nmcli con show --active | grep Wired)" != "" ]; then
        local wired="Wired Connection\n"
    fi

    case $STATE_WIFI in
        "enabled") launch "$__offmaster_w$wired$cons_SSID" $CONFIG $STATE_WIFI ;;
        "disabled") launch "$__onmaster_w$wired$cons_SSID" $CONFIG $STATE_WIFI;;
    esac

    case $option in
        "Turn wifi on") togglewifi && main ;;
        "Turn wifi off") togglewifi && main ;;
        "Refresh") main ;;
        "Wired Connection") showwired_w ;;
        $_SPA) main ;;
        *) con_w ;;
    esac
}


main()
{
    chklist
    showmaster_w
}

main
