#!/bin/bash
FILE=/home/jakupl/.xmonad/clicker/leftdown
if [ -f "$FILE" ]; then
	xdotool mouseup 1
	rm $FILE
else
	xdotool mousedown 1
	touch $FILE
fi

