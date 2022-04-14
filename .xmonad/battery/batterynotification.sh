#!/bin/bash
marginone=20
margintwo=15
marginthree=10
marginfour=5
oldbatt=1
oldcharg="unset"


main() {
    sleep 10
    getstatus
    getbatt
    
    if [ $battery_level -lt $((marginone+1)) ]
    then
        alarmmess
    fi
    while true
    do
        getstatus
        getcharg
        getbatt
        if [ "$oldcharg" == "Discharging," ] && [ "$charging" == "Charging," ]
        then
            batteryon
        elif [ "$oldcharg" == "Charging," ] && [ "$charging" == "Discharging," ]
        then
            batteryoff
    	if [ $battery_level -lt $((marginone+1)) ]
    	then
    	   sleep 3
    	   alarmmess
    	fi 
        elif [ "$oldcharg" == "Full," ] && [ "$charging" == "Discharging," ]
        then
    	batteryoff
    	if [ $battery_level -lt $((marginone+1)) ]
    	then
    	   sleep 3
    	   alarmmess
    	fi
        elif [ "$oldcharg" == "Discharging," ] && [ "$charging" == "Full," ]
        then
    	batteryfull
        fi
        if [ "$charging" == "Discharging," ] || [ "$charging" == "Charging," ] || [ "$charging" == "Full," ]
        then
    	oldcharg=$charging
        fi
        if [ $battery_level -lt $((marginone+1)) ] && [ $oldbatt -gt $marginone ]
        then
            alarmmess
        fi
        if [ $battery_level -lt $((margintwo+1)) ] && [ $oldbatt -gt $margintwo ]
        then
    	alarmmess
        fi
        if [ $battery_level -lt $((marginthree+1)) ] && [ $oldbatt -gt $marginthree ]
        then
    	alarmmess
        fi
        if [ $battery_level -lt $((marginfour+1)) ] && [ $oldbatt -gt $marginfour ]
        then
    	alarmmess
        fi
        oldbatt="$battery_level"
        sleep 5
    done
}


getstatus() {
    status=$(acpi -b)
}


getcharg() {
    charging=$(echo $status | awk '{print $3}')
}


getbatt() {
    battery_level=$(echo $status | grep -P -o '[0-9]+(?=%)') #define command getbatt. should store percentage as int
}


alarmmess() {
#    xmessage -buttons "Okay" -title "batteryalert" "ALERT! Battery is at $battery_level%" & # Going with dunstify atm
    dunstify -a "chargestatus" -u critical -h string:x-dunst-stac-tag:tag "ALERT! Battery is at $battery_level%" &
    aplay /home/jakupl/.xmonad/battery/batterysound.wav &
}


batteryon() {
    aplay /home/jakupl/.xmonad/battery/batteryon.wav &
    dunstify -a "chargestatus" -u normal -h string:x-dunst-stac-tag:tag "Charging"
}


batteryoff() {
    aplay /home/jakupl/.xmonad/battery/batteryoff.wav &
    dunstify -a "chargestatus" -u normal -h string:x-dunst-stac-tag:tag "Discharging"
}


batteryfull() {
    aplay /home/jakupl/.xmonad/battery/batteryfull.wav &
    dunstify -a "chargestatus" -u normal -h string:x-dunst-stac-tag:tag "Charging (full)"
}


# Running main!
main
