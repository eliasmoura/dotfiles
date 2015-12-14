#!/bin/bash
source $(dirname $0)/config.sh
XPOS=$((1180 + $XOFFSET))
WIDTH="180"
LINES="9"
playing=$(mpc current)

artist=$(mpc current -f %artist%)
album=$(mpc current -f %album%)
track=$(mpc current -f %title%)
date=$(mpc current -f %date%)
mpd_control="mpc --quiet"
#stats=$(mpc stats)
#playlistcurrent=$(mpc playlist | grep -n "$playing" | cut -d ":" -f 1 | head -n1)
#nextnum=$(( $playlistcurrent + 1 ))
#prevnum=$(( $playlistcurrent - 1 ))
#next=$(mpc playlist | sed -n ""$nextnum"p")
#prev=$(mpc playlist | sed -n ""$prevnum"p")
#art=$(ls ~/.config/ario/covers | grep SMALL | grep $album)
cover_dir="$HOME/.config/ario/covers"
art="$cover_dir/$(ls ~/.config/ario/covers | grep -v SMALL | grep "$(mpc current -f %album% | sed 's/:/ /g')")"
perc=`mpc | awk 'NR == 2 {gsub(/[()%]/,""); print $4}'`

percbar=`echo -e "$perc" | gdbar -bg $bar_bg -fg $foreground -h 1 -w $(($WIDTH-20))`

#84x84
#(echo "^fg($highlight)Music"; 
#echo " ";
#echo "^ca(1,/home/sunn/.xmonad/scripts/dzen_lyrics.sh) Track: ^fg($highlight)$track^ca()"; 
#echo "^ca(1,/home/sunn/.xmonad/scripts/dzen_artistinfo.sh)^fg() Artist: ^fg($highlight)$artist^ca()";
#echo "^ca(1,/home/sunn/.xmonad/scripts/dzen_albuminfo.sh)^fg() Album: ^fg($highlight)$album^ca()"; 
#echo "^ca(1,/home/sunn/.xmonad/scripts/dzen_lyrics.sh) Year: ^fg($highlight)$date^ca()"; 
#echo " $percbar"; 
#echo " ^ca(1, ncmpcpp prev) ^fg($white0)^i(/home/sunn/.xmonad/dzen2/prev.xbm) ^ca()    \
#^ca(1, ncmpcpp pause) ^i(/home/sunn/.xmonad/dzen2/pause.xbm) ^ca()                     \
#^ca(1, ncmpcpp play) ^i(/home/sunn/.xmonad/dzen2/play.xbm) ^ca()                       \
#^ca(1, ncmpcpp next) ^i(/home/sunn/.xmonad/dzen2/next.xbm) ^ca()"                      ;
#echo " "                                                                               ;
#sleep 15) | dzen2 -fg $foreground -bg $background -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse,hide;button1=exit;button3=exit' &
#template="$track - $playing $album \n$artist"
#echo "^fg($highlight)$template"

#Media buttons
prev="^ca(1, $mpd_control prev) ^i($HOME/.config/dzen2/icons/prev.xbm) ^ca()"
pause="^ca(1, $mpd_control pause) ^i($HOME/.config/dzen2/icons/pause.xbm) ^ca()"
play="^ca(1, $mpd_control play) ^i($HOME/.config/dzen2/icons/play.xbm) ^ca()"
next="^ca(1, $mpd_control next) ^i($HOME/.config/dzen2/icons/next.xbm) ^ca()"
media_control="$prev $pause $play $next"


#feh -x -B black -^ "" -g 108x108+$(($XPOS-108))+$(($YPOS+12)) -Z "$art" &
 (
 echo "Playing Now" # Fist line goes to title
 # The following lines go to slave window
 echo "Track: $track"
 echo "Artist: $artist"
 echo "Album: $album"
 echo "year: $date"
 echo "$percbar"
 echo "$media_control"
 echo " "
 sleep 15
 ) | dzen2 -p 10 -x $XPOS -y "30" -w $WIDTH -l $LINES -sa 'l' -ta 'c'\
    -title-name 'popup_mpd' -e 'onstart=uncollapse,hide;button1=exit;button3=exit' &
 sleep 15
#killall feh
