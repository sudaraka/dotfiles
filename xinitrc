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

xbacklight -set 10
xset -dpms
xset s off

#init-monitors
xrandr --output HDMI1 --auto --primary --output LVDS1 --off

exec i3 -V >> /tmp/i3.log 2>&1
