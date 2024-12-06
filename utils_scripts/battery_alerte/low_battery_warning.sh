#!/bin/bash
bat_files="/sys/class/power_supply/BAT0"
bat_status=$(cat ${bat_files}/status)
capacity=$(cat "${bat_files}/capacity")
if [[ ${bat_status}=="Discharging" && ${capacity} -le 30 ]]; then
    echo "Battery alert - ${capacity}%"
    notify-send -u critical --icon=/usr/local/share/icons/battery_low_dark.png "Low battery" "Only ${capacity}% battery remaining"
fi
