#!/usr/bin/env python3
import os
import sys
import math

if len(sys.argv) != 2:
    print("Usage: volume.py [option] (where option is up or dn)")
    sys.exit(1)

## get current volume
stream = os.popen('''amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1''')
current = float(stream.read().strip())

command = "amixer -q sset Master {amount}%{plusorminus}"

step = 5

if sys.argv[1] == "up":
    if current < 5:
        step=1
    sign = "+"
    new = min(100, current + step)
elif sys.argv[1] == "dn":
    if current <= 5:
        step=1
    sign = "-"
    new = current - step
else:
    print("Usage: volume.py [option] (where option is up or dn)")
    sys.exit(1)

# Send actual command
os.system(command.format(plusorminus=sign, amount=step))
# Send notification using dunst
notify_command = 'dunstify -a "volumeChange" -u low -h string:x-dunst-stack-tag:tag -h int:value:"{newval}" "{newval}%"'
os.system(notify_command.format(newval=round(new)))

#print(output)
