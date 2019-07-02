## General Aliases ##

## Current company aliases ##
source ~/.work_aliases

## Ubuntu default ##

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

## Git

alias gpull='git pull'

alias gs='git status'

alias gss='git status --short'

alias gct='git checkout'

alias gcm='git commit'

alias cdroot='cd $(git root)'

## Vim

alias vimf='vim $(fzf)'

## Dirdiff

function dirdiff()
{
    # Shell-escape each path:
    DIR1=$(printf '%q' "$1"); shift
    DIR2=$(printf '%q' "$1"); shift
    vim $@ -c "DirDiff $DIR1 $DIR2"
}


