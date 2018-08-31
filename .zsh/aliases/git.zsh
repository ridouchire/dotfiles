if [ -f /usr/bin/git ]; then
    alias gbranch="git checkout -B"
    alias commit="git commit -S"
    alias gpick="git cherry-pick"
    alias gstat="git status"
    alias gpush="git push -u origin"
fi
