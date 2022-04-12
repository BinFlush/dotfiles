amixer -q sset Master 2%-

vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($7 == "off") { print "MM" } else { print $2 }}' | head -n 1)

dunstify -a "volumeChange" -u low -h string:x-dunst-stack-tag:tag -h int:value:"$vol" "$vol%"
