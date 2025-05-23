#!/bin/bash
ips=(192.168.1.142)
clsport=${1:-52111}


listen_clipboard() {
    for ip in "${ips[@]}"; do
        socat TCP-LISTEN:$clsport,fork EXEC:"wl-copy" &
    done
}

send_clipboard() {
    while clipnotify; do
        content=$(wl-paste -n)
        for ip in "${ips[@]}"; do
						echo "$content" | socat - TCP:$ip:$clsport
        done
    done
}

listen_clipboard &
send_clipboard
