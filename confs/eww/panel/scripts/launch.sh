#! /bin/bash 


ext=""
eww_spawned=$(pidof eww)
mon=1
[[ $1 != "" ]] &&  ext="--config $1" 
[[ ! $eww_spawned ]] && eww daemon $ext

function toggle_eww(){ 
   if [[ -f "/tmp/ewwtriggered" ]];then
      rm /tmp/ewwtriggered
      eww close-all $ext
   else 
      touch /tmp/ewwtriggered
      eww open-many $(eww windows $ext) $ext
   fi
}



focused_mon=$(hyprctl monitors -j | jq '.[] | select(.focused==true).id')
if [[ ! $(grep "monitor ${focused_mon}" ~/.config/eww/eww.yuck) ]];then
   [[ $focused_mon == 1 ]] && mon=0
   sed -i "s/monitor\ ${mon}/monitor\ ${focused_mon}/g" ~/.config/eww/eww.yuck
fi



toggle_eww
