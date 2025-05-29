#!/bin/bash

BAT=BAT0

function battery_status(){
	 data=$(cat /sys/class/power_supply/$BAT/status)
	 echo $data
}

function battery_percentage(){
	 data=$(cat /sys/class/power_supply/$BAT/capacity)
	 echo $data
}


case $1 in 
	 "status") battery_status;;
	 "perc") battery_percentage;;
esac
