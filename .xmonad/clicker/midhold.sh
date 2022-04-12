#!/bin/bash
FILE=/tmp/middown
if [ -f "$FILE" ]; then
	xdotool mouseup 2
	rm $FILE
else
	xdotool mousedown 2
	touch $FILE
fi

