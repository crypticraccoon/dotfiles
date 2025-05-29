#!/bin/bash

icon=""

thermalZone=$1
temp=$(cat "/sys/class/thermal/${thermalZone}/temp")
temp=$(echo ${temp:0:2})
load=$(cat "/proc/loadavg" | awk '{print $1,$2,$3}')


freq=$( cat /proc/cpuinfo |awk '/MHz/{print $4}')
cpuFreq=0.0
for i in $freq;do
	 cpuFreq=$(echo "scale=2; $cpuFreq + $i" | bc)
done
clockSpeed=$(echo "scale=2;$cpuFreq/8" | bc)


printf '{
  "icon":"%s",
  "clockSpeed":"%s",
  "load":"%s",
  "temp":"%s"
}\n'  "${icon}" "${clockSpeed}" "${load}" "${temp}"


