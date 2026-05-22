[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ ! -n $(ps -e | grep 'tmux: client') ]] && exec niri-session -l

#[[ ! -n $(ps -e | grep 'tmux: client') ]] && niri-session
