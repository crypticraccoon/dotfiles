[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ ! -n $(ps -e | grep 'tmux: client') ]] && exec Hyprland
