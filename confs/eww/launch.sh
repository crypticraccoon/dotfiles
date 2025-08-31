#!/bin/bash 

args=$1 
config=$2
ewwLoaded=$(pidof eww)

if [[ ! $ewwLoaded ]];then
	 #eww daemon > /dev/null 2>&1
	 eww daemon 
fi

while true; do
	 if [[ $(eww ping) == "pong" ]];then
			eww open $args 
			#eww open $args > /dev/null 2>&1
			break
	 fi
	 notify-send "Failed to start eww daemon"
done 


