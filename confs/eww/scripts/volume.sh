#!/bin/bash

type=$1
cardSource=$2 
cVolume=$(pactl get-sink-volume $cardSource | awk '{print $5}' | tr -d '\[%\]')
mVolume=$(pactl get-source-volume $cardSource | awk '{print $5}' | tr -d '\[%\]')
echo $cVolume


if [[ $type == "--icon" ]];then
	 if [[ $cVolume -gt 70 ]];then
			echo ""
	 elif [[ $cVolume -lt 70 && $cVolume -gt 30 ]];then
			echo ""
	 elif [[ $cVolume -lt 30 ]];then
			echo ""
	 elif [[ $cVolume == 0 ]];then
			echo "󰖁"
	 fi

fi

if [[ $type == "--value" ]];then 
	 echo $cVolume
fi

if [[ $type == "--mvalue" ]];then 
	 echo $mVolume
fi
