#!/bin/sh

interval=0

# U 0
cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c#3b414d^ ^b#7ec7a2^ CPU"
  printf "^c#abb2bf^ ^b#353b45^ $cpu_val"
}

update_icon() {
  printf "^c#7ec7a2^ "
}

pkg_updates() {
  updates="$(echo N | sudo dnf update | grep Upgrade | cut -d ' ' -f 3)"

  if [ -z "$updates" ]; then
    printf "^c#7ec7a2^ 0"
  else
    printf "^c#7ec7a2^ $updates"
  fi
}

# battery
batt() {
  printf "^c#81A1C1^  "
  printf "^c#81A1C1^ $(acpi | sed "s/,//g" | awk '{if ($3 == "Discharging"){print $4; exit} else {print $4""}}' | tr -d \n)"
}

brightness() {

  backlight() {
    backlight="$(light | cut -d '.' -f 1)"
    echo -e "$backlight"
  }

  printf "^c#BF616A^   "
  printf "^c#BF616A^%.0f\n" $(backlight)
}

volume() {
    master="$(amixer get Master | grep % | cut -d '[' -f 2 | cut -d \n -f 1 | cut -d % -f 1)"
    capture="$(amixer get Capture | grep % | cut -d '[' -f 2 | cut -d \n -f 1 | cut -d % -f 1)"


    printf "^c#7797b7^ R $master "
}

mem() {
  printf "^c#7797b7^^b#1e222a^ RAM "
  printf "^c#7797b7^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
  case "$(nmcli radio wifi)" in
      enabled) printf "^c#3b414d^ ^b#7aa2f7^ 󰤨 ^d^%s" " ^c#7aa2f7^" ;;
      disabled) printf "^c#3b414d^ ^b#7aa2f7^ 󰤭 ^d^%s" " ^c#7aa2f7^" ;;
  esac
}

clock() {
  printf "^c#1e222a^ ^b#668ee3^ 󱑆 "
  printf "^c#1e222a^^b#7aa2f7^ $(date '+%a, %I:%M %p') "
}

while true; do

  [ $interval == 0 ] || [ $(($interval % 3600)) == 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$(brightness) $(volume) $(cpu) $(mem) $(wlan) $(clock)"
done
