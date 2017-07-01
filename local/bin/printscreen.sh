#!/bin/bash

area(){
  notify-send "--geometry=$(slop) $1"
  maim --geometry="$(slop)" "$1"
}

fullscreen(){
  read -r W H < <(xrandr --current | awk -F " " '/current/ {printf("%d %d\n",$8, $10)}')
  maim -w "$W" -h "$H" -x 0 -y 0 "$1"
}

record(){
  eval "$(slop)"
  maim -w "$W" -h "$H" -x "$X" -y "$Y" "$1"
}

path=~/pictures/screenshots/$(date +%F-%T).png
# path=~/writing/org/static/tutorial/emacs_basico/emacs-0"$(ll ~/writings/org/static/tutorial/emacs_basico/* | wc -l)".png
case $1 in
  window)
    area "$path"
    maim --geometry="$(slop)" "$path"
    ;;
  area)
    maim -s "$path"
    ;;
  record)
    record "$path"
    ;;
  fullscreen)
    maim "$path"
esac
