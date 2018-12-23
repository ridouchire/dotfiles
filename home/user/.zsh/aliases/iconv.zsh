if [ -f /usr/bin/iconv ]; then
    alias -g convKU="| iconv -c -f koi8r -t utf8"  
    alias -g convCU="| iconv -c -f cp1251 -t utf8"
    alias -g convUK="| iconv -c -f utf8 -t koi8r"  
    alias -g convUC="| iconv -c -f utf8 -t cp1251"
fi
