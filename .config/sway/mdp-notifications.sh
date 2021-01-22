#! /bin/sh

#
# this script needs mako-git from AUR and brightnessctl
#

playerctld daemon

COMMAND=$1

SYMBOL_FULL=' '
SYMBOL_EMPTY=$SYMBOL_FULL
PLAY_PAUSE="play"
STATUS=`playerctl status`

if [ "$COMMAND" = "play" ] && [ "$STATUS" = "Playing" ]
then
  COMMAND="pause"
fi

ICON="$HOME/.config/sway/icons/mdp-$COMMAND.svg"

show_notification () {
  notify-send.sh \
    --replace-file=/tmp/mdp-notification \
    -c "XF86BINDING_MDP" \
    -i $ICON \
    -t 1000 \
    "" \
    ""
}

PLAY_PAUSE="play"


case $COMMAND in
  "play")
    playerctl play
    show_notification
    ;;
  
  "pause")
    playerctl pause
    show_notification
    ;;

  "next")
    playerctl next
    show_notification
    ;;
  
  "previous")
    playerctl previous
    show_notification
    ;;
  
  *)
    playerctl status
    ;;
esac
