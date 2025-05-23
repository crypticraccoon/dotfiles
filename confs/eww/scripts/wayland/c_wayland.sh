#!/bin/bash
#<Right>hyprctl activewindow A-j | jq --raw-output .title
hyprctl activeworkspace | head -1 |awk '{print $3}
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | stdbuf -o0 grep '^activewindow>>' | stdbuf -o0 awk -F '>>|,' '{print $3}'

