#!/bin/bash

current=$(gsettings get org.gnome.desktop.interface color-scheme)

#Tmux follows the same + tmux source-file ~.config/tmux/tmux.conf
alacrittyLightTheme=$(cat -n alacritty.toml	| grep -m "1" 1 | awk '{print $2}')
alacrittyDarkTheme=$(cat -n alacritty.toml	| grep -m "1" 2 | awk '{print $2}')


#NVIM
tmux list-panes -a -F '#{pane_id} #{pane_current_command}' |
grep vim |
cut -d ' ' -f 1 |
xargs -I PANE tmux send-keys -t PANE ESCAPE ":set background=$mode" ENTER

sed -i "s/set.background = \"light\"/set.background = \"dark\"/g" $nvimConfigFile
sed -i "s/set.background = \"dark\"/set.background = \"light\"/g" $nvimConfigFile


if [[ $current == "prefer-light" ]];then
	 gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

	 #Remove the # from the light theme
	 sed -i "s/$alacrittyDarkTheme/${alacrittyLightTheme//#/}/g"
	 #add the # from the light theme
	 sed -i "s/$alacrittyLightTheme/# $alacrittyDarkTheme/g"


elif [[ $current == "prefer-dark" ]];then
	 gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
	 sed -i "s/$alacrittyLightTheme/${alacrittyDarkTheme//#/}/g"


fi


function handleGnome(){}
function handleTerminal(){}
function handleNvim(){}
function handleTmux(){}
function handleBg(){}


