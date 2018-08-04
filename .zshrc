autoload -U compinit promptinit
compinit
promptinit
prompt clint
zstyle ':completion:*' menu select
setopt completealiases
setopt HIST_IGNORE_DUPS

if [ -f /usr/bin/grc ]; then
 alias gcc="grc --colour=auto gcc"
 alias irclog="grc --colour=auto irclog"
 alias log="grc --colour=auto log"
 alias netstat="grc --colour=auto netstat"
 alias ping="grc --colour=auto ping"
 alias proftpd="grc --colour=auto proftpd"
 alias traceroute="grc --colour=auto traceroute"
fi

DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
## Удалить повторяющиеся записи
setopt pushdignoredups
## Это Отменяет +/- операторы.
setopt pushdminus

HISTFILE=~/.zsh-history
SAVEHIST=1000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY 
setopt histexpiredupsfirst histfindnodups
setopt CORRECT_ALL
setopt AUTO_CD
setopt SH_WORD_SPLIT
setopt IGNORE_EOF
setopt NO_BEEP
setopt extended_glob
setopt correct
setopt MENUCOMPLETE
setopt nohup
setopt ZLE
setopt MULTIBYTE
setopt NUMERIC_GLOB_SORT

ccd() { cd $1 && ls}
rmd(){ local P="`pwd`"; cd .. && rmdir "$P" || cd "$P"; }
rnm() {
    name=$1
    vared -c -p 'Переименовать в: ' name
    command mv $1 $name
}

mkd() { mkdir $1; cd $1 }

unpack() {
if [ -f $1 ] ; then
case $1 in
 *.tar.bz2)   tar xjf $1        ;;
 *.tar.gz)    tar xzf $1     ;;
 *.bz2)       bunzip2 $1       ;;
 *.rar)       unrar x $1     ;;
 *.gz)        gunzip $1     ;;
 *.tar)       tar xf $1        ;;
 *.tbz2)      tar xjf $1      ;;
 *.tgz)       tar xzf $1       ;;
 *.zip)       unzip $1     ;;
 *.Z)         uncompress $1  ;;
 *.7z)        7z x $1    ;;
 *)           echo "$fg_bold[red]Ошибка:$reset_color Невозможно распаковать '$1'..." ;;
esac
else
echo "$fg_bold[red]Ошибка:$reset_color '$1' - неподдерживаемый тип файла"
fi
}

pack() {
if [ $1 ] ; then
case $1 in
 tbz)    tar cjvf $2.tar.bz2 $2      ;;
 tgz)    tar czvf $2.tar.gz  $2    ;;
 tar)   tar cpvf $2.tar  $2       ;;
 bz2) bzip $2 ;;
 gz)  gzip -c -9 -n $2 > $2.gz ;;
 zip)    zip -r $2.zip $2   ;;
 7z)     7z a $2.7z $2    ;;
 *)      echo "$fg_bold[red]Ошибка:$reset_color '$1' не может быть упакован через pack()" ;;
esac
else
echo "$fg_bold[red]Ошибка:$reset_color '$1' - неподдерживаемый тип файла"
fi
}

ccopy(){ cp $1 /tmp/ccopy.$1; }
alias cpaste="ls /tmp/ccopy.* | sed 's|/tmp/ccopy.||' | xargs -I % mv /tmp/ccopy.% ./%"

alias mv='nocorrect mv -i'
alias cp='nocorrect cp -iR'
alias rm='nocorrect rm -i'
alias rmf='nocorrect rm -f'
alias rmrf='nocorrect rm -fR'
alias mkdir='nocorrect mkdir'
alias ls='ls --color=auto'   
alias lsd='ls -ld .*'    
alias lls='ls -alFh --color=auto'
alias grep='grep --color=auto'   
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias -g convKU="| iconv -c -f koi8r -t utf8"  
alias -g convCU="| iconv -c -f cp1251 -t utf8"
alias -g convUK="| iconv -c -f utf8 -t koi8r"  
alias -g convUC="| iconv -c -f utf8 -t cp1251"  
alias df='df -h'
alias du='du -h'
alias psgrep='ps aux | grep $(echo $1 | sed "s/^\(.\)/[\1]/g")'
alias dirtree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'
alias mocp='/usr/bin/mocp-scrobbler.py -d; mocp'

alias -s {txt,log,list}=emacs
alias -s {pdf,djvu}="nohup zathura"
alias -s {avi,mpeg,mpg,mov,m2v,flv}="nohup mpv"
alias -s {ogg,mp3,wav,m3u,pls}="nohup mpv"
alias -s {jpg,jpeg,png,gif,tif,tiff,bmp}="nohup gpicview"

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=$color[cyan]=$color[red]"
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command' 
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*::::' completer _expand _complete _correct _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format '> %B%d%b'
zstyle ':completion:*:messages' format '> %d'
zstyle ':completion:*:warnings' format '> Ошибка: нет совпадений для: %d'
zstyle ':completion:*:corrections' format '> %B%d (число ошибок: %e)%b'
zstyle ':completion:*:correct:*' insert-unambiguous true
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:correct:*' prompt 'исправить на:'
zstyle ':completion:*' prompt 'Исправить (число ошибок: %e) > '
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~''*?.old' '*?.pro'
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:incremental:*' completer _complete _correct
zstyle ':completion:*:predict:*' completer _complete
zstyle ':mime:*' x-browsers firefox rekonq google-chrome konqueror chromium-browser
zstyle ':mime:*' tty-browsers w3m elinks links lynx
zstyle -e ':completion:*' hosts 'reply=($myhosts)'
zstyle ':completion:*' insert-tab true
zstyle ':completion:*' select-prompt '%SСтрока: %LЭлемент: %M[%p]%s'
zstyle ':completion:*' list-prompt '%SТекущее положение: %p%s'
zstyle ':completion:*' sort true
zstyle ':completion:*' file-sort name
zstyle ':completion:*' keep-prefix changed
zstyle ':completion:*:man:*' separate-sections true
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes select
zstyle ':completion:*' old-menu true
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' word true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:(ssh|scp|ftp):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|ftp):*' users $users
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*:*:*:users' ignored-patterns adm apache bin daemon games gdm halt ident junkbust lp mail mailnull named news nfsnobody nobody nscd ntp operator pcap postgres radvd rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
zstyle ':completion:*' rehash true
