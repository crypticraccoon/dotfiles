#! /bin/bash
state=`eww get VOLUME_ICON $1 $2`

if [[ $state == "󰕾" ]];then 
	 echo $1 $2
	 mute=`eww update VOLUME_ICON='󰝟' $1 $2; amixer -qc 1 set Master mute `
	 echo "$mute"
else 
	 unmute=`eww update VOLUME_ICON='󰕾' $1 $2;  amixer -qc 1 set Master unmute `
	 echo "$unmute"
fi
