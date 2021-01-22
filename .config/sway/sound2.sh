#!/bin/sh

#
# this script needs mako-git from AUR
#

DEVICE=$1
COMMAND=$2

ICON_VOLUME="$HOME/.config/sway/icons/volume-$DEVICE.svg"
ICON_MUTED="$HOME/.config/sway/icons/volume-$DEVICE-muted.svg"
SYMBOL_FULL=' '
SYMBOL_EMPTY=$SYMBOL_FULL

function mixer () {
  args=()
  [[ "$DEVICE" == "source" ]] && args+=(--default-source)
  pamixer "${args[@]}" "$@"
}

MUTED=$(mixer --get-mute)

show_notification () {
  volume=$(mixer --get-volume)
  muted=$(mixer --get-mute)

  full=""
  empty=""
  icon=$ICON_VOLUME

  full_size=$(( volume / 10 ))
  empty_size=$(( 10 - full_size ))

  if [ "$muted" = "true" ]; then empty_size=10; icon=$ICON_MUTED; fi
  if [ "$full_size" -gt 0 ] && [ "$muted" = "false" ]; then full=$(printf "${SYMBOL_FULL}%.0s" $(seq $full_size)); fi
  if [ "$empty_size" -gt 0 ]; then empty=$(printf "${SYMBOL_EMPTY}%.0s" $(seq $empty_size)); fi

  message="<span font='13'><b>"`
    `"<span foreground='#e5e9f0'>${full}</span>"`
    `"<span foreground='#3b4252'>${empty}</span>"`
  `"</b></span>"

  notify-send.sh \
    --replace-file=/tmp/volume-notification \
    -c "XF86BINDING" \
    -i $icon \
    -t 2000 \
    "Volume ${volume}%" \
    "${message}"
}

case $COMMAND in

  "up")
    [[ "$MUTED" = "false" ]] && mixer -i 5
    show_notification
    ;;

  "down")
    [[ "$MUTED" = "false" ]] && mixer -d 5
    show_notification
    ;;

  "toggle")
    mixer -t
    show_notification
    ;;

  *)
    mixer --get-volume-human
    ;;

  esac
