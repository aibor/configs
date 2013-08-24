#!/bin/sh

xset +fp /usr/share/fonts/local
xset fp rehash
xset -dpms
xset s off
xsetroot -solid "#000000"

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

#exec openbox-session
exec i3
