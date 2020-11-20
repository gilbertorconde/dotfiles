#! /bin/sh

notify-send -t 1500 "Screen Cast" "Starting cast your screen"
wf-recorder --muxer=v4l2 --codec=rawvideo --pixel-format=yuv420p --file=/dev/video2 -g "$(slurp)"
