#! /bin/sh
export GOPATH=$HOME/go # GOPATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH" # pyenv executables
export PATH="$HOME/.yarn/bin:$PATH" # binaries installed by yarn
export PATH="$GOPATH/bin:$PATH" # golang binaries
export PATH="$HOME/.bin:$PATH" # binaries from dotfiles
export PATH="$HOME/.cargo/bin:$PATH" # binaries installed by cargo
export PATH="$HOME/.scripts:$HOME/.scripts/statusbar:$PATH" # some of my scripts
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH" # haskell
export PATH="$HOME/.local/bin:$PATH" # local binaries
export PATH="$HOME/.roswell/bin:$PATH" # roswell binaries

export LANG="en_US.UTF-8"
export LC_COLLATE="C"

export NVIM_TUI_ENABLE_TRUE_COLOR=1

# default programs
export WINDOW_MANAGER=awesome

export FILE=ranger

export TERMINAL=alacritty

export ALTERNATE_EDITOR=""
export EDITOR=ec
export VISUAL=v

export BROWSER=firefox
# setup GPG(not needed)
# export GPG_TTY=$(tty)

# fixes misbehaving java programs in dwm and bspwm
export _JAVA_AWT_WM_NONREPARENTING=1

if [ -d "$HOME/.profile.d" ]; then
    for f in $HOME/.profile.d/*.sh; do
        . $f
    done
fi

