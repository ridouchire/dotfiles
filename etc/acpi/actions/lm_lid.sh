#! /bin/sh

DISPLAY=:0.0 su ridouchire -c 'i3lock -i /home/ridouchire/.local/data/locked.png'

test -f /lib/udev/lmt-udev || exit 0

# lid button pressed/released event handler
/lib/udev/lmt-udev
