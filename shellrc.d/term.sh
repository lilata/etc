#! /bin/env sh
if [ -n "$TMUX" ]; then
    export TERM=tmux-256color
else
    export TERM=xterm-256color
fi
