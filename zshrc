# Path to your oh-my-zsh installation.
export ZSH="/home/matheus-frata/.oh-my-zsh"

HIST_STAMPS="mm/dd/yyyy"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Pure theme
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

alias ungron="gron --ungron"

# Source job aliases
[ -f ~/.work_aliases ] && source ~/.work_aliases

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
