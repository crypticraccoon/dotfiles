#!/bin/bash

type=$1
cBrightnessStripped=$(brightnessctl  | grep -oP '(\d|\d\d|\d\d\d)%' | awk -F% '{print $1}')


if [[ $type == "--icon" ]];then
	 if [[ $cBrightnessStripped -gt 70 ]];then
			echo "󰃞"
	 elif [[ $cBrightnessStripped -lt 70 && $cBrightnessStripped -gt 30 ]];then
			echo "󰃟"
	 elif [[ $cBrightnessStripped -lt 30 ]];then
			echo "󰃝"
	 fi
fi


if [[ $type == "--value" ]];then 
	 echo $cBrightnessStripped
fi


if [[ $type == "--dec" ]];then 
	 brightnessctl s 5-% >/dev/null;
elif [[ $type == "--inc" ]];then 
	 brightnessctl s +5% >/dev/null;
fi
