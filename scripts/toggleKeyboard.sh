#!/bin/bash

itemState=$1
item=$2

if [[ $item == "" ]];then
	 item="keyboard"
fi


sysFs="/sys/$(cat /proc/bus/input/devices | grep -A3 $item | awk -F= '/Sysfs/{print $2; exit}')/inhibited"

if [[ ! -f $sysFs ]];then
	 echo "Unable to loacate file path."
	 exit 1
fi

echo $sysFs
state=$(cat $sysFs)

if [[ $itemState == "on" ]];then 
	 echo 1 | sudo tee $sysFs >/dev/null
elif [[ $itemState == "off" ]];then
	 echo 0 | sudo tee $sysFs >/dev/null
fi

