#!/bin/bash
FILE=/home/jakupl/.xmonad/clicker/middown
if [ -f "$FILE" ]; then
	xdotool mouseup 2
	rm $FILE
else
	xdotool mousedown 2
	touch $FILE
fi

