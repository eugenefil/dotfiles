#!/bin/sh

[ -f ~/.Xresources ] && xrdb -l ~/.Xresources &
xset dpms 2400 2400 2400 &
~/bin/setkbd &
~/bin/chmouse l &
exec openbox --startup ~/.config/openbox/autostart.sh
