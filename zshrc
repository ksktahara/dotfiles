# K.Tahara's zshrc

setopt histignorealldups sharehistory autocd extendedglob nomatch
unsetopt beep notify

# history
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# prompt
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    base_prompt="%F{green}%n@%m%k "
else
    base_prompt="%F{green}%n%k "
fi
post_prompt="%b%f%k"
base_prompt_no_color=${base_prompt//\%(F\{*\}|k)/}
post_prompt_no_color=${post_prompt//\%(F\{*\}|k)/}
prompt_newline=$'\n%{\r%}'

## vcs
autoload -Uz vcs_info
autoload -Uz colors
colors

setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}*"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats "[%b|%a]"

RPROMPT='${vcs_info_msg_0_}'

my_prompt_precmd () {
    setopt noxtrace localoptions
    local base_prompt_expanded_no_color base_prompt_etc
    local prompt_length space_left

    base_prompt_expanded_no_color=$(print -P "$base_prompt_no_color")
    base_prompt_etc=$(print -P "$base_prompt%~")
    prompt_length=${#base_prompt_etc}
    if [[ $prompt_length -lt 40 ]]; then
        path_prompt="%B%F{blue}%~%F{white}"
    else
        space_left=$(( $COLUMNS - $#base_prompt_expanded_no_color - 2 ))
        path_prompt="%B%F{cyan}%${space_left}<...<%~$prompt_newline%F{white}"
    fi
    PS1="$base_prompt$path_prompt %# $post_prompt"
    PS2="$base_prompt$path_prompt %_> $post_prompt"
    PS3="$base_prompt$path_prompt ?# $post_prompt"

    vcs_info
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd my_prompt_precmd

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
zstyle ':completion:*' use-compctl true # should be true to use ROS's completion
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# binding
bindkey -v
bindkey "^J" vi-cmd-mode
autoload -Uz history-search-end
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