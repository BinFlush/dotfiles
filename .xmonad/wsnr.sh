#!/bin/bash
for i in {1..9}
do
xmessage -buttons "" -title "wsnumber$i" "$i $i $i $i $i $i" &
echo "wsnumber$i" 
echo "$i $i $i $i $i $i"
done
sleep 3
pkill xmessage
exit 0
