#!/bin/bash

state=$(eww $1 $2 get KEYBOARD_ICON)
if [[ $state == "" ]];then 
   eww $1 $2 update KEYBOARD_ICON="󰌐";systemctl --user start keyboard
else 
   eww $1 $2 update KEYBOARD_ICON="";systemctl --user stop keyboard
fi

