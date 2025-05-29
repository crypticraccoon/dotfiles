#!/bin/bash

type=$1
cVolume=$(amixer sget Master | awk -F'[][]' '/Front Left:/{print $2}' | tr -d '\[%\]')
echo $cVolume


if [[ $type == "--icon" ]];then
	 if [[ $cVolumeStripped -gt 70 ]];then
			echo ""
	 elif [[ $cVolumeStripped -lt 70 && $cVolumeStripped -gt 30 ]];then
			echo ""
	 elif [[ $cVolumeStripped -lt 30 ]];then
			echo ""
	 elif [[ $cVolumeStripped == 0 ]];then
			echo "󰖁"
	 fi

fi

if [[ $type == "--value" ]];then 
	 echo $cVolume
fi
