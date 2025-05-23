#! /bin/bash
#

type=$2
function cpu_temp() {
   temp=$(cat '/sys/class/hwmon/hwmon3/temp1_input')
   echo ${temp:0:2}
}
function gpu_temp() {
   temp=$(sensors | awk '/edge/ {print $2}')
   echo ${temp:1:2}
}
function memory() {
   mem_max=$(free -h | awk '/Mem/ {printf $2}')
   mem_used=$(free -h | awk '/Mem/ {printf $3}')
   case $type in 
      "mem") echo ${mem_used:0:3}/${mem_max};;
      "perc") echo "scale=2; ${mem_used:0:3} * (100 / ${mem_max:0:2} )" | bc  ;; 
      "single") echo ${mem_used:0:3};;
      *) exit;;
   esac
}
function battery() {
   battery=$(cat /sys/class/power_supply/BAT1/capacity)
   echo $battery
}

function disk_perc(){
	 echo "123"
	 min=${df -h | awk ' /nvme0n1p9/  {printf $3}'}
	 max=${df -h | awk ' /nvme0n1p9/  {printf $2}'}
	 dec=${echo $max/$min | bc -l}
	 echo "asd"
	 echo $min $max $dec
}

case $1 in 
    "cpu_load") cpu_load;;
    "cpu_temp") cpu_temp;;
    "gpu_temp") gpu_temp;;
    "battery") battery;;
    "memory") memory;;
	  "disk_perc") disk_perc;;

   *) exit
esac

#echo $1 $2
