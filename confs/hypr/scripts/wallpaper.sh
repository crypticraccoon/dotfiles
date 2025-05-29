#! /bin/bash 

wallpaper=$1
hyprctl hyprpaper unload all

hyprctl hyprpaper preload $wallpaper && 
hyprctl hyprpaper wallpaper eDP-1,$wallpaper
hyprctl hyprpaper wallpaper HDMI-A-1,$wallpaper


