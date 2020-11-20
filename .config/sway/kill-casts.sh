#! /bin/sh

notify-send -t 1500 "Screen Cast" "Stop cast/record your screen"
killall -s SIGINT wf-recorder
killall -s SIGINT wlstreamer
