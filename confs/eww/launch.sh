#!/bin/bash 

args=$1
ewwLoaded=$(pidof eww)

if [[ ! $ewwLoaded ]];then
	 eww daemon > /dev/null 2>&1
fi

while true; do
	 if [[ $(eww ping) == "pong" ]];then
			eww open $args > /dev/null 2>&1
			break
	 fi
	 notify-send "Failed to start eww daemon"
done 


