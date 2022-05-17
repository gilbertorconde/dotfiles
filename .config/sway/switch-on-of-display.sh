#! /bin/zsh

touch /tmp/lcdeDP-1

read lcd < /tmp/lcdeDP-1
    if [ "$lcd" -eq "1" ]; then
        swaymsg "output eDP-1 dpms on"
        echo 0 > /tmp/lcdeDP-1
        echo 'on'
    else
        swaymsg "output eDP-1 dpms off"
        echo 1 > /tmp/lcdeDP-1
        echo 'off'
    fi