#!/bin/bash
#hyprctl monitors -j | jq --raw-output .[0].activeWorkspace.id
#socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | stdbuf -o0 grep '^workspace>>' | stdbuf -o0 awk -F '>>|,' '{print $2}'
#!/usr/bin/env bash

hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
  stdbuf -o0 awk -F '>>|,' -e '/^workspace>>/ {print $2}' -e '/^focusedmon>>/ {print $3}'
