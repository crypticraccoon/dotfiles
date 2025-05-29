#!/bin/bash

type=$1
destFolder="${HOME}/personal/pictures/screenshots"
fileName="$(date | awk '{print $4}').png"


if [[ $type == "--all" ]];then
	 grim "${destFolder}/${fileName}";
	 notify-send "Image: ${fileName} saved to screenshots folder."
elif [[ $type == "--window" ]];then
	 windowResolution=$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
	 grim -g "$windowResolution" "${destFolder}/${fileName}"; 
	 notify-send "Image: ${fileName} saved to screenshots folder."
elif [[ $type == "--custom" ]];then
	 grim -g "$(slurp)" - | wl-copy; 
	 notify-send "Saved screenshot to clipboard."
fi




