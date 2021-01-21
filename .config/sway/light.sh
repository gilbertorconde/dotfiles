#! /bin/sh

#
# you need to add a udev rule like: /etc/udev/rules.d/backlight.rules with:
#
# ACTION=="change", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
# ACTION=="change", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
#
# and then: sudo udevadm control --reload-rules && sudo udevadm trigger
#

DIRECTION=$1
DEFAULT_STEP=50
ACTUAL_LIGHT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
MAX_LIGHT=`cat /sys/class/backlight/intel_backlight/max_brightness`
STEP=0
SIZE=33

if [ $DIRECTION == "up" ]
then
    if [ "$(($MAX_LIGHT - $ACTUAL_LIGHT))" -ge "$(($DEFAULT_STEP))" ]
    then
        STEP="$DEFAULT_STEP"
    else
        STEP=" $MAX_LIGHT - $ACTUAL_LIGHT"
    fi
else
    if [ "$(($ACTUAL_LIGHT))" -lt "$(($DEFAULT_STEP))" ]
    then
        STEP="-$ACTUAL_LIGHT"
    else
        STEP="-$DEFAULT_STEP"
    fi
fi

echo "$(($ACTUAL_LIGHT + $STEP))"

echo "$(($ACTUAL_LIGHT + $STEP))" > /sys/class/backlight/intel_backlight/brightness

ACTUAL_LIGHT=`cat /sys/class/backlight/intel_backlight/actual_brightness`

PER="$(($ACTUAL_LIGHT * $SIZE / $MAX_LIGHT))"
REM="$(($SIZE - $PER))"
FILL=$(for i in $(seq 1 $PER); do printf "#"; done)
UNFILL=$(for i in $(seq 1 $REM); do printf " "; done)
MIDLE="$(($SIZE / 2))"
SUM=$FILL$UNFILL
PERCENTAGE="$(($ACTUAL_LIGHT * 100 / $MAX_LIGHT))"
SPACER=""
if [ $PERCENTAGE -lt 100 ]
then
    SPACER=" "
fi
if [ $PERCENTAGE -lt 10 ]
then
    SPACER="  "
fi
FINAL="${SUM:0:$MIDLE - 3} $SPACER$PERCENTAGE% ${SUM:$MIDLE + 3:$MIDLE - 2}"
# install from https://github.com/vlevit/notify-send.sh
notify-send.sh --replace-file=/tmp/brightnessnotification -t 4000 "Brightness" "[$FINAL]"
