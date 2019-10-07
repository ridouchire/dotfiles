#! /bin/sh

DISPLAY=:0.0 su ridouchire -c 'xrandr --output HDMI3 --auto'
DISPLAY=:0.0 su ridouchire -c 'xrandr --output LVDS1 --off'


test -f /lib/udev/lmt-udev || exit 0

# ac on/offline event handler
/lib/udev/lmt-udev
