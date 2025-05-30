#!/bin/bash

batteryName=$1

perc=$( cat "/sys/class/power_supply/$batteryName/capacity")
status=$( cat "/sys/class/power_supply/$batteryName/status")

icon=""


if [[ $status == "Charging" ]];then
	 icon="󰂄"
elif [[ $status == "Full" ]];then
	 icon="󰁹"
elif [[ $perc -gt 70 ]];then
 	icon="󰁼"
elif [[ $perc -lt 70 && $perc -gt 30 ]];then
 	icon="󰁾"
elif [[ $perc -lt 30 ]];then
	 notify-send "Battery low ($perc%)";
 	icon="󰂀"
elif [[ $status == "Charging" ]];then
	 icon="󰂄"
fi

printf '
{
  "icon":"%s",
  "status":"%s",
  "percentage":"%s"
}\n' "${icon}" "${status}" "${perc}"

