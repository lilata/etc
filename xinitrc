#! /bin/env sh
# .xinitrc

xrandr -s 0

xrdb $HOME/.Xresources &
xsetroot -cursor_name left_ptr &
xsetroot -solid '#80a0af' &


# if we have private ssh key(s), start ssh-agent and add the key(s)
id1=$HOME/.ssh/id_ed25519
id2=$HOME/.ssh/id_rsa
# id3=$HOME/.ssh/id_dsa
if [ -x /usr/bin/ssh-agent ] && [ -f $id1 -o -f $id2 ];
then
	eval `ssh-agent -s`
	ssh-add < /dev/null
fi

xset fp+ /usr/local/lib/X11/fonts/terminus
xset fp+ /usr/local/lib/X11/fonts/ghostscript
xset fp+ /usr/X11R6/lib/X11/fonts/TTF/

# Disable that annoying bell
xset b off &
# speed up key rate
xset r rate 300 50 &
# compositor
# xcompmgr -c &


setxkbmap -option "ctrl:nocaps"

# ibus config for CJK input method
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
# source the xprofile
[ -f $HOME/.xprofile ] && . $HOME/.xprofile
# run window manager
exec $WINDOW_MANAGER
