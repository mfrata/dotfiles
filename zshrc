# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

HIST_STAMPS="mm/dd/yyyy"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Pure theme
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Source work aliases
[ -f ~/.work_aliases ] && source ~/.work_aliases

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ungron="gron --ungron"
alias rm="trash"

path+="$HOME/.local/bin"
path+="$HOME/.cargo/bin"
path+="$HOME/.dotfiles/bin/photo"

function venv {
  [ ! -d .venv ] && python -m venv .venv
  source .venv/bin/activate
}


# python
export PYTHONDONTWRITEBYTECODE=1
