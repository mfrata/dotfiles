# Install 
export ZPLUG_HOME=~/.config/zsh/zplug
if [[ ! -d $ZPLUG_HOME ]]; then
  echo "ZPLUG_HOME not found cloning..."
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "momo-lab/zsh-abbrev-alias"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
if ! zplug check; then
    zplug install
fi
zplug load

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
## case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

abbrev-alias ll='ls -alF --color=auto'
abbrev-alias la='ls -A --color=auto'
abbrev-alias ls='ls -CF --color=auto'
abbrev-alias gs='git status'
abbrev-alias gss='git status --short'

function remove_trailing_spaces {
    sed -i 's/[ \t]*$//' ${1}
}

SAVEHIST=10000
HISTFILE=~/.zsh_history

# Source job aliases
 [ -f ~/.work_aliases ] && source .work_aliases

export PATH=$PATH:$HOME/.local/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
