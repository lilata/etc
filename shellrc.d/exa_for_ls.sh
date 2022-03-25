#! /bin/sh
if hash exa > /dev/null 2>&1
then
alias ls='exa'
alias l='exa -Flah'
fi
