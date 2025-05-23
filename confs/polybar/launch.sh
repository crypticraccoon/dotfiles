#!/bin/sh
DIR="${POLYBAR}/blocks"

killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1 ; done

#if type "xrandr"; then
  #for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #echo "External Monitor"
    #MONITOR=$m polybar -q bar1 -c "$DIR/bars.ini" &
  #done
#else
  polybar -q outer_left  -c ${DIR}/bars.ini &
  polybar -q inner_left  -c "$DIR/bars.ini" &
  polybar -q center 	 -c "$DIR/bars.ini" &
  polybar -q inner_right -c "$DIR/bars.ini" &
  polybar -q outer_right -c "$DIR/bars.ini" &
#fi

