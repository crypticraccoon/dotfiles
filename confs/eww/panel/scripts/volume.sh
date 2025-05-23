#! /bin/bash

state=$(eww get VOLUME_ICON)

if [[ $state == "󰕾" ]];then 
   eww update VOLUME_ICON="󰝟";  amixer -qc 1 set Master mute 
else 
   eww update VOLUME_ICON="󰕾";  amixer -qc 1 set Master unmute
fi







