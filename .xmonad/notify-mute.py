#!/usr/bin/env python3
import os

## get current notification status
# stream = os.popen('dunstctl is-paused')
# current = stream.read().rstrip()

# if stream == 'false':
    # msg = 'notifications muted'
# elif stream == 'true':
    # msg = 'notifications unmuted'

os.system('dunstify -h string:x-dunst-stack-tag:test "Notifications ON"')
os.system('dunstctl set-paused toggle')

