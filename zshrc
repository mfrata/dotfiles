# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

HIST_STAMPS="mm/dd/yyyy"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Pure theme
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Add nord colors to pure
# https://www.nordtheme.com/#palettes-modularity
zmodload zsh/nearcolor
zstyle :prompt:pure:path color '#5e81ac'
zstyle :prompt:pure:prompt:success color '#8fbcbb'
zstyle :prompt:pure:prompt:error color '#bf616a'
zstyle :prompt:pure:execution_time color '#ebcb8b'
zstyle :prompt:pure:git:branch color '#88c0d0'
zstyle :prompt:pure:git:dirty color '#b48ead'

# Source work aliases
[ -f ~/.work_aliases ] && source ~/.work_aliases

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ungron="gron --ungron"
alias rm="trash"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


path+="$HOME/.local/bin"
path+="$HOME/.cargo/bin"
path+="$HOME/.dotfiles/bin/photo"
path+="$HOME/.local/share/coursier/bin"
path+="/opt/homebrew/bin"
path+="$HOME/Library/Application Support/Coursier/bin"

function venv {
  [ ! -d .venv ] && python$1 -m venv .venv
  source .venv/bin/activate
}

# docker
export DOCKER_BUILDKIT=1
if [ "$(uname -m)" = "arm64" ]
then
  export DOCKER_DEFAULT_PLATFORM=linux/arm64
fi

export TERM=xterm-256color

# python
export PYTHONDONTWRITEBYTECODE=1
alias pytest="pytest -p no:cacheprovider"

GCP_INSTALL_PATH="$HOME/.local/google-cloud-sdk"
[ -f "$GCP_INSTALL_PATH/path.zsh.inc" ] && . "$GCP_INSTALL_PATH/path.zsh.inc"
[ -f "$GCP_INSTALL_PATH/completion.zsh.inc" ] && . "$GCP_INSTALL_PATH/completion.zsh.inc"

eval $(thefuck --alias)
