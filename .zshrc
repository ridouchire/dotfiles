autoload -U compinit promptinit
compinit
promptinit
prompt clint

DIRSTACKSIZE=20
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
HISTFILE=~/.zsh-history
SAVEHIST=1000

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi

if [ -f ~/.zsh/functions.zsh ]; then
    source ~/.zsh/functions.zsh 
else
    echo "ERROR: ~/zsh/functions.zsh not found."
fi

if [ -f ~/.zsh/aliases.zsh ]; then
    source ~/.zsh/aliases.zsh
else
    echo "ERROR: ~/zsh/aliases.zsh not found."
fi

if [ -f ~/.zsh/zstyles.zsh ]; then
    source ~/.zsh/zstyles.zsh
else
    echo "ERROR: ~/zsh/zstyles.zsh not found."
fi

setopt completealiases
setopt HIST_IGNORE_DUPS
setopt autopushd pushdsilent pushdtohome
setopt pushdignoredups
setopt pushdminus
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
