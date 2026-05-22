set -g status-style 'bg=default,fg=#ffffff'
set-option -g status-right '#[bg=#1bfd9c , fg=#000000,bold] #S '
set-option -g status-left ''

set -g window-status-format "#[fg=#ffffff,bg=#303030,bold] #I #[fg=#ffffff,bg=#404040,bold] #W "
set -g window-status-current-format "#[fg=#000000,bg=#1bfd9c,bold] #I #[fg=#000000,bg=#ffffff ,bold] #W "

set -g message-style bg=#1bfd9c,fg=#1d1d1d,bold
set -g message-command-style bg=#1d1d1d,fg=#1bfd9c,bold

set -g pane-active-border-style fg=#1bfd9c
set -g pane-border-style fg=#555555

