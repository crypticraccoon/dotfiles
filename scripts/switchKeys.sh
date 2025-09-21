#!/bin/bash 

 #sudo  xremap ~/personal/dotfiles/confs/xremap/config.yml $(~/personal/dotfiles/scripts/getDeviceId.sh "--device" keyboard Keychron) >/dev/null

#prefix="$1"
#shift
config="$1"
shift

resString=""

for arg in "$@"; do
	 echo $arg
	 resString+="--device /dev/input/$(cat /proc/bus/input/devices | grep -b5 $arg | grep -oP 'event(\d\d|\d)') "
done

sudo xremap $config $resString


