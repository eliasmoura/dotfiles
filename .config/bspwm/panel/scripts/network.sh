#!/bin/sh
source $(dirname $0)/config.sh

XPOS=$((1180 + $XOFFSET))
WIDTH="500"
LINES="9"
playing=$(mpc current)


#Media buttons
prev="^ca(1, $mpd_control prev) ^i($HOME/.config/dzen2/icons/prev.xbm) ^ca()"
pause="^ca(1, $mpd_control pause) ^i($HOME/.config/dzen2/icons/pause.xbm) ^ca()"
play="^ca(1, $mpd_control play) ^i($HOME/.config/dzen2/icons/play.xbm) ^ca()"
next="^ca(1, $mpd_control next) ^i($HOME/.config/dzen2/icons/next.xbm) ^ca()"
media_control="$prev $pause $play $next"


 (
 vnstat
 ) | dzen2 -p 10 -x $XPOS -y "30" -w $WIDTH -l $LINES -sa 'l' -ta 'c'\
    -title-name 'popup_mpd' -e 'onstart=uncollapse,hide;button1=exit;button3=exit' &
 sleep 15
