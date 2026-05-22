set -g status-style 'bg=default,fg=#fff4d2'
set-option -g status-right '#[bg=#d8a657 , fg=#000000,bold] #S '
set-option -g status-left ''

set -g window-status-format "#[fg=#ebdbb2,bg=#303030,bold] #I #[fg=#ebdbb2,bg=#404040,bold] #W "
set -g window-status-current-format "#[fg=#000000,bg=#d8a657,bold] #I #[fg=#000000,bg=#83a598 ,bold] #W "

set -g message-style bg=#d8a657,fg=#1d1d1d,bold
set -g message-command-style bg=#1d1d1d,fg=#d8a657,bold

set -g pane-active-border-style fg=#8ec07c
set -g pane-border-style fg=#555555
