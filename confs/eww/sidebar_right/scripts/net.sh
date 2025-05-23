#! /bin/sh
card='wlp1s0'
interval=2
declare -i rpf=0
frpf=0.0
return=$1


function get_speed {
prefix=" B/s"
rpf=$1
frpf=$1

if [ $rpf -ge 1000 ]; then
	frpf=$(echo "scale=2 ; $frpf/1000.0"|bc)
	rpf=$(($rpf/1000))
	prefix=" KB/s"
fi
if [ $rpf -ge 1000 ]; then
	frpf=$(echo "scale=2 ; $frpf/1000.0"|bc)
	prefix=" MB/s"
fi
}

rx1=$(cat /sys/class/net/wlp1s0/statistics/rx_bytes)
tx1=$(cat /sys/class/net/wlp1s0/statistics/tx_bytes)
sleep $interval
rx2=$(cat /sys/class/net/wlp1s0/statistics/rx_bytes)
tx2=$(cat /sys/class/net/wlp1s0/statistics/tx_bytes)

rx=$((($rx2-$rx1)/$interval))
tx=$((($tx2-$tx1)/$interval))
get_speed $rx

if [[ ! $return ]];then 
   #echo -n " $frpf$prefix "
   #get_speed $tx
   #echo "  $frpf$prefix "
   echo -n " $frpf  "
   get_speed $tx
   echo "  $frpf "
elif [[ $return == "down" ]];then 
   echo $frpf
elif [[ $return == "pre" ]];then 
   echo $prefix
fi 










