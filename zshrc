#! /bin/env zsh
SAVEHIST=10000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history

autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}%b$ "
# set to vim mode and vim cursor
#
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1
bindkey -v
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt
bindkey '^[[P' delete-char

# zsh prompt
autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M:%{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}"$'\n'"$ "
# complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files in autocomplete:
_comp_options+=(globdots)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# edit command line
autoload edit-command-line; zle -N edit-command-line
bindkey  ^x^e edit-command-line
stty -ixon

# shellrc
[ -f "$HOME/.shellrc" ] && source "$HOME/.shellrc"

# load files
ZSHRC_DIR="$HOME/.zshrc.d"
if [ -d "$ZSHRC_DIR" ]; then
    for f in $HOME/.zshrc.d/*.zsh; do
        source $f
    done
fi

# PATH dedup
export PATH=$(printf "%s" "$PATH" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')

