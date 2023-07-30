#! /bin/bash

chosen=$(printf "Power Off\nSuspend\nHibernate\nRestart\nLog Out" | rofi -dmenu -p "Power menu:")

case "$chosen" in
    "Power Off")
        chosen=$(printf "Yes\nNo" | rofi -dmenu -selected-row 1 -p "Are you sure?")
        if [[ "$chosen" == "Yes" ]]; then
            poweroff
        fi ;;
    "Suspend") systemctl suspend ;;
    "Hibernate") systemctl hibernate ;;
    "Restart")
        chosen=$(printf "Yes\nNo" | rofi -dmenu -p "Are you sure?")
        if [[ "$chosen" == "Yes" ]]; then
            reboot
        fi ;;
    "Log Out")
        chosen=$(printf "Yes\nNo" | rofi -dmenu -p "Are you sure?")
        if [[ "$chosen" == "Yes" ]]; then
            hyprctl dispatch exit
        fi ;;
    *) exit 1 ;;
esac
