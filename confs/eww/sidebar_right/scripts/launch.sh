#! /bin/bash 
ext=""
eww_spawned=$(pidof eww)
mon=1
[[ $1 != "" ]] &&  ext="--config $1" 
function toggle_eww(){ 
   if [[  $eww_spawned ]]
	 then eww close-all $ext
   else eww open bar $ext 
	 fi
}

if [[ ! $eww_spawned ]];then eww daemon $ext; toggle_eww; fi

