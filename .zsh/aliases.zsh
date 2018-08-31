alias mv='nocorrect mv -i'
alias cp='nocorrect cp -iR'
alias rm='nocorrect rm -i'
alias rmf='nocorrect rm -f'
alias rmrf='nocorrect rm -fR'
alias mkdir='nocorrect mkdir'
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

# hooks
for file in $HOME/.zsh/aliases/*
do
    source $file
done
