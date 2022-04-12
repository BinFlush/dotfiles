#!/bin/bash
FILE=/tmp/rightdown
if [ -f "$FILE" ]; then
	xdotool mouseup 3
	rm $FILE
else
	xdotool mousedown 3
	touch $FILE
fi

