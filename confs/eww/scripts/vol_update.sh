value=$(amixer -c 1 sget Master | awk '/Mono/ {printf $4}' | tr -d '\[%\]')
c_value=$((value))
x=5

if [[ $1 == "down" && $c_value != 0 ]];then 
	 if [[ $((c_value - x)) -gt 0 ]];then 
			amixer -qc 1 set Master $((c_value - x))%
	 else 
			amixer -qc 1 set Master 0
	 fi
elif [[ $1 == "up" && $c_value != 100 ]];then 
	 if [[ $((c_value + x)) -lt 100 ]];then 
			amixer -qc 1 set Master $((c_value + x))%
	 else
			amixer -qc 1 set Master 100
	 fi
fi
