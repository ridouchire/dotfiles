if [ -f /usr/bin/grc ]; then
    alias gcc="grc --colour=auto gcc"
    alias log="grc --colour=auto log"
    alias netstat="grc --colour=auto netstat"
    alias ping="grc --colour=auto ping"
    alias traceroute="grc --colour=auto traceroute"
fi

if [ -f /usr/bin/iconv ]; then
    alias -g convKU="| iconv -c -f koi8r -t utf8"  
    alias -g convCU="| iconv -c -f cp1251 -t utf8"
    alias -g convUK="| iconv -c -f utf8 -t koi8r"  
    alias -g convUC="| iconv -c -f utf8 -t cp1251"
fi

if [[ -f /usr/bin/mocp ]] && [[ -f /usr/local/bin/mocpscrob ]]; then
    alias mocp='/usr/local/bin/mocpscrob -d; mocp'
fi

if [ -f /usr/bin/mc ]; then
    alias mc='mc -S gotar'
fi

if [ -f /usr/bin/mysql ]; then
    alias sql='mysql -uroot -proot -h'
fi

if [ -f /usr/bin/emacs ]; then
    alias -s {txt,log,list}=emacs
fi

if [ -f /usr/bin/zathura ]; then
    alias -s {pdf,djvu}="nohup zathura"
fi

if [ -f /usr/bin/mpv ]; then
    alias -s {avi,mpeg,mpg,mov,m2v,flv}="nohup mpv"
    alias -s {ogg,mp3,wav,m3u,pls}="nohup mpv"
fi

if [ -f /usr/bin/gpicview ]; then
    alias -s {jpg,jpeg,png,gif,tif,tiff,bmp}="nohup gpicview"
fi

if [ -f /usr/bin/git ]; then
    alias gbranch="git checkout -B"
    alias commit="git commit -S"
    alias gpick="git cherry-pick"
    alias gstat="git status"
    alias gpush="git push -u origin"
fi

alias mv='nocorrect mv -i'
alias cp='nocorrect cp -iR'
alias rm='nocorrect rm -i'
alias rmf='nocorrect rm -f'
alias rmrf='nocorrect rm -fR'
alias mkdir='nocorrect mkdir'
alias df='df -h'
alias du='du -h'
alias ls='ls --color=auto'   
alias lsd='ls -ld .*'    
alias lls='ls -alFh --color=auto'
alias grep='grep --color=auto -n'   
alias fgrep='fgrep --color=auto -n'
alias egrep='egrep --color=auto -n'
alias rgrep='rgrep --color -n'
alias psgrep='ps aux | grep $(echo $1 | sed "s/^\(.\)/[\1]/g")'
alias dirtree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

# ssh aliases
alias tox='ssh -D 8888 root@image-hosting'
