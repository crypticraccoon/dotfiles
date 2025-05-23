value=$(xbacklight -get)
c_value=$((value))


if [[ $1 == "down" && $c_value != 0 ]];then 
	 if [[ $((c_value + x)) -gt 0 ]];then 
			sudo xbacklight -set $((c_value - 5))
	 else
			sudo xbacklight -set 0
	 fi
elif [[ $1 == "up" && $c_value != 100 ]];then 
	 if [[ $((c_value + x)) -lt 100 ]];then 
			sudo xbacklight -set $((c_value + 5))
	 else 
			sudo xbacklight -set 100

	 fi
fi
