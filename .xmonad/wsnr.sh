#!/bin/bash
for i in {1..9}
do
#xmessage -buttons "" -print "$i $i $i $i $i $i" -title "wsnumber$i" &
xmessage -center -buttons "" -title "wsnumber$i"  "wwe wef we fwe fwe fw ef wef we w ef e \n " &
echo "wsnumber$i" 
echo "$i $i $i $i $i $i"
done
sleep 3
pkill xmessage
exit 0
