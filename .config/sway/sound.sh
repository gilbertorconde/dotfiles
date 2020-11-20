#! /bin/sh

SIZE=33
DIRECTION=$1

if [ $DIRECTION == "up" ]
then
    amixer -D pulse sset Master 5%+
else
    amixer -D pulse sset Master 5%-
fi

ACTUAL_LEVEL=`amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }'`
ACTUAL_LEVEL=${ACTUAL_LEVEL::-1}
PER="$(($ACTUAL_LEVEL * $SIZE / 100))"
REM="$(($SIZE - $PER))"
FILL=$(for i in $(seq 1 $PER); do printf "#"; done)
UNFILL=$(for i in $(seq 1 $REM); do printf " "; done)
MIDLE="$(($SIZE / 2))"
SUM=$FILL$UNFILL
SPACER=""
if [ $ACTUAL_LEVEL -lt 100 ]
then
    SPACER=" "
fi
if [ $ACTUAL_LEVEL -lt 10 ]
then
    SPACER="  "
fi
FINAL="${SUM:0:$MIDLE - 3} $SPACER$ACTUAL_LEVEL% ${SUM:$MIDLE + 3:$MIDLE - 2}"

notify-send.sh --replace-file=/tmp/soundnotification -t 4000 "Sound volume" "[$FINAL]"
