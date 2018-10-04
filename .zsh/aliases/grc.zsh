if [ -f /usr/bin/grc ]; then
    alias gcc="grc --colour=auto gcc"
    alias netstat="grc --colour=auto netstat"
    alias ping="grc --colour=auto ping"
    alias ping6="grc --colour=auto ping6"
    alias traceroute="grc --colour=auto traceroute"
    alias df="grc --colour=auto df -h"
fi
