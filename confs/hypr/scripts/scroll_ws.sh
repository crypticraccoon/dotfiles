#!/bin/bash

c_ws=$(hyprctl activeworkspace | head -1 |awk '{print $3}')

if [[ $1 == "left" ]];then
	 if [[ $c_ws == 1 ]];then	exit; fi
	 hyprctl dispatch workspace $(echo  $c_ws - 1 | bc) 
elif [[ $1 == "right" ]]; then
	 if [[ $c_ws == 10 ]];then	exit; fi
	 hyprctl dispatch workspace $(echo  $c_ws + 1 | bc) 
fi


