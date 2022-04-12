#!/bin/bash
for i in {1..9}
do
xmessage -buttons "" -title "wsnr$i" "$i $i $i $i $i $i" &
done
sleep 2
pkill xmessage
exit 0
