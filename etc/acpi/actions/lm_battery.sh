#! /bin/sh

DISPLAY=:0.0 su ridouchire -c 'xrandr --output LVDS1 --auto'
DISPLAY=:0.0 su ridouchire -c 'xrandr --output HDMI3 --off'

test -f /lib/udev/lmt-udev || exit 0

# Automatically disable laptop mode when the battery almost runs out,
# and re-enable it when it
/lib/udev/lmt-udev
