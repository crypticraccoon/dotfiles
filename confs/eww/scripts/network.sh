#! /bin/sh


icon="   "
card=$1
interval=2
declare -i rpf=0
frpf=0.0
type=$2


function get_speed {
prefix=" B/s"
rpf=$1
frpf=$1

if [ $rpf -ge 1000 ]; then
	frpf=$(echo "scale=2 ; $frpf/1000.0"|bc)
	rpf=$(($rpf/1000))
	prefix="KB/s"
fi
if [ $rpf -ge 1000 ]; then
	frpf=$(echo "scale=2 ; $frpf/1000.0"|bc)
	prefix="MB/s"
fi
}

rx1=$(cat /sys/class/net/${card}/statistics/rx_bytes)
tx1=$(cat /sys/class/net/${card}/statistics/tx_bytes)
sleep $interval
rx2=$(cat /sys/class/net/${card}/statistics/rx_bytes)
tx2=$(cat /sys/class/net/${card}/statistics/tx_bytes)

rx=$((($rx2-$rx1)/$interval))
tx=$((($tx2-$tx1)/$interval))
get_speed $rx
down="$frpf $prefix"
get_speed $tx
printf '
{
  "icon":"%s",
  "down":"%s",
  "up":"%s %s"
}\n' "${icon}"  "${down}" "${frpf}" "${prefix}"










