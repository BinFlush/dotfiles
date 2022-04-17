#!/bin/bash
PICTURE=/tmp/scsht.png
BLURRED="$PICTURE"_blur.png
scrot -oF $PICTURE 
convert -scale 10% -blur 0x2.5 -resize 1000% $PICTURE $BLURRED
rm $PICTURE
i3lock -tf -i $BLURRED

