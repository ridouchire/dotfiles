#!/bin/bash

CURRENT=`cat /sys/class/backlight/intel_backlight/brightness`
MAXIMUM=3000;
MINIMIM=100;
STEP=350

if [ "$1" = "+" ]; then
    let "CURRENT = CURRENT + STEP"
    if [ "$CURRENT" -gt "$MAXIMUM" ]; then
        let "CURRENT = MAXIMUM"
    fi
else
    let "CURRENT = CURRENT - STEP"
    if [ "$CURRENT" -lt "$MINIMUM" ]; then
        let "CURRENT = MINIMUM"
    fi
fi

echo -n "$CURRENT" | sudo tee /sys/class/backlight/intel_backlight/brightness
