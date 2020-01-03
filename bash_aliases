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

function get_commit_hash()
{
  git tree | grep -E ${1} | cut -d ' ' -f2 | xclip -i -selection clipboard
}

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

function remove_trailing_spaces {
    sed -i 's/[ \t]*$//' ${1}
}


