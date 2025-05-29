#!/bin/bash

g=1048576

icon=" "

total=$(cat /proc/meminfo | awk '/MemTotal/{print $2}')
total=$(echo "scale=2;$total/$g" | bc)


free=$(cat /proc/meminfo | awk '/MemAvailable/{print $2}')
free=$(echo "scale=2;$free/$g" | bc)

used=$(echo "scale=2;$total - $free" | bc)

perc=$(echo "scale=2;( $used / $total ) * ( 100/1 )" | bc)


printf '
{
  "icon":"%s"
  "total":"%s",
  "used":"%s",
  "free":"%s",
  "percentage":"%s",
}\n' "${icon}" "${total}" "${used}" "${free}" "${perc}"

