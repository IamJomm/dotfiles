#! /bin/bash

chosen=$(printf "Change brightness\nConnect to Network" | rofi -dmenu -p "Option:")

case "$chosen" in
    "Connect to Network")
        chosen=$(nmcli -t -f ssid dev wifi | sort | uniq | grep -v '^$' | rofi -dmenu -p "Choose Network:")
        nmcli dev wifi connect $chosen
        while [[ $? != 0 && $chosen != "" ]]; do
            password=$(rofi -dmenu -p "Password:")
            if [[ $password == "" ]]; then break; fi
            nmcli dev wifi connect $chosen password $password
        done ;;
    "Change brightness")
        chosen=$(printf "25%%\n50%%\n75%%\n100%%" | rofi -dmenu -p "Brightness value:" -selected-row 2)
        brightnessctl set $chosen ;;
esac
