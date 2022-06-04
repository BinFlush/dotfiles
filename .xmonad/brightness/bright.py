#!/usr/bin/env python3
import os
import sys
import math

BRIGHTNESS_FILES_DIRECTORY = '/sys/class/backlight/intel_backlight'
def main():
    if len(sys.argv) != 2:
        print("Usage: brightup.py [option] (where option is up or dn)")
        sys.exit(1)
    
    ## get current backlight level in percentage
    current = getcurrentprc_raw()
    print(current)
    
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
    setbacklight_raw(output)
    # Send notification using dunst
    notify_command = 'dunstify -a "bright" -u low -h string:x-dunst-stack-tag:tag -h int:value:"{brightval}" "{brightval}%"'
    os.system(notify_command.format(brightval=round(output,1))) #print(output)

def getcurrentprc_xbacklight():
    stream = os.popen('xbacklight')
    current = float(stream.read().rstrip())
    return current

def setbacklight_xbacklight(output):
    command = "xbacklight -set {level}"
    os.system(command.format(level=output))

def getcurrentprc_raw():
    maxfile = BRIGHTNESS_FILES_DIRECTORY+'/max_brightness'
    with open(maxfile) as fp:
        Lines = fp.readlines()
        global maxbrightness
        maxbrightness = int(Lines[0].rstrip())

    currentfile = BRIGHTNESS_FILES_DIRECTORY+'/brightness'
    with open(currentfile) as fp:
        Lines = fp.readlines()
        current_abs = int(Lines[0].rstrip())
    return current_abs / maxbrightness * 100

def setbacklight_raw(output):
    print('old output er', output)
    output = round(output * maxbrightness / 100)
    print('max er', maxbrightness)
    print(type(output))
    print('new output er', output)
    with open(BRIGHTNESS_FILES_DIRECTORY+'/brightness', 'w') as fp:
        fp.writelines([str(output)])

if __name__ == "__main__":
    main()
