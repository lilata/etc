#! /usr/bin/env zsh
[ "$ZSH_ANTIGEN_DISABLE" = "1" ] && return 0
ANTIGEN="$HOME/.zshrc.d/antigen/antigen.zsh"
[ -f "$ANTIGEN" ] || return 0
source "$ANTIGEN"
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

antigen apply
