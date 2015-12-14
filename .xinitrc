#!/bin/sh
#
# ~/.xinitrc
#
# Executed by `startx` (run your window manager from here)

#maybe will need this
#if [ ! "$DBUS_SESSION_BUS_ADDRESS" ] && have dbus-launch; then
#    exec dbus-launch --exit-with-session ~/.xinitrc "$@" || exit
#fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xsetroot -human left_ptr &  # sets the cursor icon

##font stuff
xset +fp /usr/share/fonts/misc
xset +fp /usr/share/fonts/TTF
xset fp rehash

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f redshift ]] && redshift &

setxkbmap -layout br,ru -variant ,phonetic -option grp:menu_toggle,compose:caps

ponymix unmute &
nitrogen --restore
#tmux-create default                                   #script to create a standard tmux session
compton &

sxhkd &
exec bspwm -c ~/.config/bspwm/bspwmrc
#exec spectrwm
#exec herbstluftwm
