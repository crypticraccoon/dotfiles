#!/bin/bash 

configFile=$1
args=$2
echo "+++++++++++++++++++++++++++++++++++++++++"


ewwLoaded=$(pidof eww)
if [[ ! $ewwLoaded ]];then
	 echo 'starting'
	 eww daemon --force-wayland --config $configFile
else
	 echo 'restarting'
	 eww daemon --restart --force-wayland --config $configFile
fi
sleep 5
echo "closing"
echo $configFile
echo "+++++++++++++++++++++++++++++++++++++++++"

eww close-all --config $configFile
echo "============="
eww open-many $args --force-wayland --config $configFile


