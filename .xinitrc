#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
xsetroot -cursor_name left_ptr & # Sets mouse pointer
setxkbmap fo,dk -option grp:ctrls_toggle & # Toggle with both control keys.
xmobar &
stalonetray &
nm-applet &
#nitrogen --restore &
nitrogen --set-scaled --random ~/Pictures/wallpapers/wallpapers &
bash ~/.xmonad/battery/batterynotification.sh &
#picom --experimental-backends -D 4 &
unclutter --timeout 8 &
xautolock -time 5 -locker "~/.xmonad/lockscreen_blur.py lock" &
touch /tmp/.lockon &
rm -rf /home/jakupl/Downloads/* &
export EDITOR=nvim
exec xmonad

