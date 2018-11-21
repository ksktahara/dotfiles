# K.Tahara's zshrc

# prompt
autoload -Uz promptinit
promptinit
prompt adam1 green blue

setopt histignorealldups sharehistory autocd extendedglob nomatch
unsetopt beep notify

# history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# completion
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# binding
bindkey -v
bindkey "^J" vi-cmd-mode
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey -M vicmd "?" history-incremental-search-backward
bindkey -M vicmd "/" history-incremental-search-forward

# alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l='ls -Ch'
alias ll='ls -Bltrh'
alias la='ls -altrh'
alias less='less -R'
alias info='info --vi-keys'

# set envs just once.
# should be in ~/.profile or something. but I want to be portable.
if [ -z "${DOTFILES_ENV_SET+1}" ]; then
    export DOTFILES_ENV_SET=1
    export PATH=$PATH:$HOME/dotfiles/scripts
fi
