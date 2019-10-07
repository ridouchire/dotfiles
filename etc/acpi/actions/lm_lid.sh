#! /bin/sh

DISPLAY=:0.0 su ridouchire -c 'i3lock -c 111111'

test -f /lib/udev/lmt-udev || exit 0

# lid button pressed/released event handler
/lib/udev/lmt-udev
