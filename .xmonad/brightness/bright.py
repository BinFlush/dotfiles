#!/usr/bin/env python3
import os
import sys
import math

if len(sys.argv) != 2:
    print("Usage: brightup.py [option] (where option is up or dn)")
    sys.exit(1)

## get current backlight level
stream = os.popen('xbacklight')
current = float(stream.read().rstrip())

modifier = 1.2 # sensitivity.. must be >1, and higher means larger steps.
if sys.argv[1] == "up":
    if current == 0:
        output = 0.2
    else:
        output = min(current * modifier + 1, 100)
elif sys.argv[1] == "dn":
    if current < 0.5:
        output = 0
    else:
        output = max(current / modifier, 0)
else:
    print("Usage: brightup.py [option] (where option is up or dn)")
    sys.exit(1)

# Send actual command
command = "xbacklight -set {level}"
os.system(command.format(level=output))
# Send notification using dunst
notify_command = 'dunstify -a "bright" -u low -h string:x-dunst-stack-tag:tag -h int:value:"{brightval}" "{brightval}%"'
os.system(notify_command.format(brightval=round(output,1)))

#print(output)
