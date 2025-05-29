#!/bin/bash


memTotal=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
memFree=$(awk '/MemFree/ {print $2}' /proc/meminfo)
memUsed=$(awk '/Active/ {print $2}' /proc/meminfo)

echo $memTotal
echo $memFree
#echo $memUsed

echo $(($memTotal - $memFree))
#xx="$((($memTotal - $memUsed) * (100/$memTotal)))"
xx=$((( $memTotal - $memFree) * ($memTotal/100)))
echo $xx

#x=$(echo "scale=2; ${memUsed} * (100 / ${memTotal} )" | bc)
#echo $x

