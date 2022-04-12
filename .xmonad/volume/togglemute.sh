#!/bin/bash

CURRENT_STATE=`amixer get Master | egrep 'Playback.*?\[o' | egrep -o '\[o.+\]' | head -n 1`

if [[ $CURRENT_STATE == '[on]' ]]; then
    amixer set Master mute
    dunstify -a "volumeChange" -i audio-volume-muted-symbolic.symbolic -u low -h string:x-dunst-stack-tag:tag  -h string:x-dunst-origin-tag:"center" "Muted"
else
    amixer set Master unmute
    amixer set Front unmute
    amixer set Headphone unmute
    vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1)
    dunstify -a "volumeChange" -i audio-volume-high-symbolic.symbolic -u low -h string:x-dunst-stack-tag:tag  -h int:value:"$vol" "Unmuted - $vol%"
fi
