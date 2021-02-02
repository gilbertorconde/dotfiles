#! /bin/sh
FOCUSED='((.id  | tostring) + "\t<span foreground=\"green\">" + .app_id + .window_properties.class + "</span>\t" + .name + "\t")'
UNFOCUSED='((.id  | tostring) + "\t<span foreground=\"white\">" + .app_id + .window_properties.class + "</span>\t" + .name + "\t")'
wofires=`swaymsg -t get_tree |
jq -r ".nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end + .floating_nodes | .[] | select(.nodes==[]) | select(.type!=\"workspace\") | if .focused then $FOCUSED else $UNFOCUSED end" |
column -ts $'\t' |
 wofi --show dmenu`

IFS=' ' read -ra ADDR <<< "$wofires"
swaymsg "[con_id=${ADDR[0]}]" focus
