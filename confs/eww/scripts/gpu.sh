#!/bin/bash

icon=""
mIcon=""

data=$( amdgpu_top -d -J |  jq --arg mIcon "$mIcon" --arg icon "$icon" '
{
			name: "GPU",
			icon: $icon, 
			mIcon: $mIcon,
			vram:{total:.[0].VRAM."Total VRAM".value, 
			used:.[0].VRAM."Total VRAM Usage".value},
			temp:.[0].Sensors."Edge Temperature".value ,
			power:.[0].Sensors."Input Power".value, 
}' )

printf '%s' "${data}"


