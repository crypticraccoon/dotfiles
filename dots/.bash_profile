[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ ! -n $(ps -e | grep 'tmux: client') ]] && exec niri --session
