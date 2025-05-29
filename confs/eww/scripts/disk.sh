#!/bin/bash

partition=$1

icon="󰋊"

dec=$(df -h | awk -v partition="$partition" '$0 ~ partition{print $0}')

perc=$(echo $dec | awk '{print $5}' | sed 's/\%//g')
free=$(echo $dec | awk '{print $4}')
used=$(echo $dec | awk '{print $3}')
total=$(echo $dec | awk '{print $2}')

printf '
{
  "icon":"%s",
  "total":"%s",
  "used":"%s",
  "free":"%s",
  "percentage":"%s"
}\n' "${icon}" "${total}" "${used}" "${free}" "${perc}"
