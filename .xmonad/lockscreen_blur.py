#!/usr/bin/env python3
import os
import sys

if len(sys.argv) != 2:
    print("Usage: lockscreen_blur.py [option] (where option is 'lock' or 'toggle')")
    sys.exit(1)

if sys.argv[1] == "lock":
    PICTURE = "/tmp/scsht.png"
    BLURRED = PICTURE + "_blur.png"
    os.system("scrot -oF {picture}".format(picture=PICTURE))
    os.system("convert -scale 10% -blur 0x2.5 -resize 1000% {picture} {blurred}".format(picture=PICTURE, blurred=BLURRED))
    os.system("rm {picture}".format(picture=PICTURE))
    ## check if notifications are on. If yes, turn them off.
    stream = os.popen('dunstctl is-paused')
    current = stream.read().rstrip()
    if current == "false":
        os.system("dunstctl set-paused true")
    os.system("i3lock -tf --nofork -i {blurred}".format(blurred=BLURRED))
    if current == "false":
        os.system("dunstctl set-paused false")
        
    sys.exit(0)

if sys.argv[1] == "toggle":
    # Check if lockfile exists
    lockfile = "/tmp/.lockon"
    notify_cmd = 'dunstify -a "lockscreenChange" -u low -h string:x-dunst-stack-tag:tag  -h string:x-dunst-origin-tag:"center" "{msg}"'
    if os.path.exists(lockfile):
        # Lockscreen is on. Disabling
        os.system("xautolock -disable")
        os.system("rm {file}".format(file=lockfile))
        os.system(notify_cmd.format(msg="Lockscreen Disabled"))
    else:
        # Lockscreen is off. Enabling
        os.system("xautolock -enable")
        os.system("touch {file}".format(file=lockfile))
        os.system(notify_cmd.format(msg="Lockscreen Enabled"))
    sys.exit(0)


print("Usage: lockscreen_blur.py [option] (where option is 'lock' or 'toggle')")
sys.exit(1)

