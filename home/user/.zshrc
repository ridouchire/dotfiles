export PATH=$PATH:$HOME/.composer/vendor/bin
autoload -U compinit promptinit
compinit
promptinit

DIRSTACKSIZE=20
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
HISTFILE=~/.zsh-history
HISTSIZE=10000000
SAVEHIST=10000000

setopt extended_history
alias history='fc -il 1'
setopt share_history
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_NO_STORE
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP

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

source ~/.zsh/libs/zsh-git/zshrc.sh
PROMPT='%B%~%b$(git_super_status) '
