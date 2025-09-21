#!/bin/bash

itemState=$1
item=$2

if [[ $item == "" ]];then
	 item="keyboard"
fi

sysFs="/sys/$(cat /proc/bus/input/devices | grep -A3 $item | awk -F= '/Sysfs/{print $2}')/inhibited"

if [[ ! -f $sysFs ]];then
	 exit 1
fi

state=$(cat $sysFs)

if [[ $itemState == "on" ]];then 
	 echo 1 | sudo tee $sysFs >/dev/null
elif [[ $itemState == "off" ]];then
	 echo 0 | sudo tee $sysFs >/dev/null
fi

