zstyle ':completion:*' menu select
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
zstyle ':completion:*' insert-tab true
zstyle ':completion:*' select-prompt '%SСтрока: %LЭлемент: %M[%p]%s'
zstyle ':completion:*' list-prompt '%SТекущее положение: %p%s'
zstyle ':completion:*' sort true
zstyle ':completion:*' file-sort name
zstyle ':completion:*' keep-prefix changed
zstyle ':completion:*:man:*' separate-sections true
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list true
zstyle ':completion:*:history-words' menu yes select
zstyle ':completion:*' old-menu true
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' word true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*:*:*:users' ignored-patterns adm apache bin daemon games gdm halt ident junkbust lp mail mailnull named news nfsnobody nobody nscd ntp operator pcap postgres radvd rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
zstyle ':completion:*' rehash true
