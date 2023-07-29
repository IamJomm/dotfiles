#! /bin/sh

chosen=$(printf "Power Off\nSuspend\nHibernate\nRestart\nLock" | rofi -dmenu)

case "$chosen" in
    "Power Off") poweroff ;;
    "Suspend") systemctl suspend ;;
    "Hibernate") systemctl hibernate ;;
    "Restart") reboot ;;
    *) exit 1 ;;
esac
