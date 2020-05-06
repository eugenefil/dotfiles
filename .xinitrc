#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -l ~/.Xresources
~/.xkb/setup-xkb
xset r rate 130 150
xset dpms 2400 2400 2400
~/bin/mice l
exec openbox
