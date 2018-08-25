autoload -U compinit promptinit
compinit
promptinit

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
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY 
setopt CORRECT_ALL
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
setopt APPEND_HISTORY
setopt HIST_REDUCE_BLANKS


bindkey "^[[2~" yank
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[e" expand-cmd-path
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
bindkey " " magic-space

source ~/.zsh/zsh-git/zshrc.sh 
PROMPT='%B%~%b$(git_super_status) '
