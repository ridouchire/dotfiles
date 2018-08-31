if [ -f /usr/bin/grc ]; then
    alias gcc="grc --colour=auto gcc"
    alias log="grc --colour=auto log"
    alias netstat="grc --colour=auto netstat"
    alias ping="grc --colour=auto ping"
    alias traceroute="grc --colour=auto traceroute"
    alias df="grc --colour=auto df -h"
fi
