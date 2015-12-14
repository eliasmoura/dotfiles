#!/bin/sh
# info.sh
# based from https://github.com/neeasade/dotfiles
# Output general information with formatted background colors in bar-aint-recursive format
# default location for a battery capacity

export BATC=/sys/class/power_supply/BAT0/capacity
source ~/.config/bspwm/panel/symbols
source ~/.config/bspwm/panel/panel.cfg

clock() {
    date '+%d %m %Y %H:%M'
}

battery() {
    BATS=/sys/class/power_supply/BAT0/status
    #Check if there is a battery on the cyrrent computer we are on.
    if [ -f $BATC ]; then
        test "`cat $BATS`" = "Charging" && echo -n '+' || echo -n '-'
        sed -n p $BATC
    else
        #yeah
        echo "+0"
    fi
}

volume() {
    ponymix get-volume
}

network() {
    read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`
    if iwconfig $int1 >/dev/null 2>&1; then
        wifi=$int1
        eth0=$int2
    else
        wifi=$int2
        eth0=$int1
    fi

    ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 ||int=$wifi
    #int=eth0

    ping -c 1 8.8.8.8 >/dev/null 2>&1 &&
        status="%{F$COLOR_STATUS_FG}${WIFI}" || status="%{F$COLOR_URGENT_FG}${DU}"

    #netspeed
    # original: https://bitbucket.org/jasonwryan/workstation/src/7c79a4574d84/scripts/speed.sh
    RXB=$(cat /sys/class/net/${int}/statistics/rx_bytes)
    TXB=$(cat /sys/class/net/${int}/statistics/tx_bytes)
    sleep 2
    RXBN=$(cat /sys/class/net/${int}/statistics/rx_bytes)
    TXBN=$(cat /sys/class/net/${int}/statistics/tx_bytes)
    RXDIF=$(echo -e $((RXBN - RXB)) )
    TXDIF=$(echo -e $((TXBN - TXB)) )
    RXT=$(ifconfig ${int} | awk '/bytes/ {print $2}' | cut -d: -f2)
    TXT=$(ifconfig ${int} | awk '/bytes/ {print $6}' | cut -d: -f2)

    echo -e "${status}${AD}$((RXDIF / 1024 / 2)) ${AU}$((TXDIF / 1024 / 2))%{F-}"

}
#From bslackr from the archlinux forum
keyboard_indicator() {
    echo -e "$(setxkbmap -query | awk '/layout/ {print $2}' )"
}

battery_status(){
  ac="$(awk '{ gsub(/%|%,/, "");} NR==1 {print $4}' <(acpi -V))"
  on="$(grep "on-line" <(acpi -V))"
  if [ -z "$on" ] && [ "$ac" -gt "15" ]; then
    echo -e "\uE04F \x02$ac%\x05 |\x01"
  elif [ -z "$on" ] && [ "$ac" -le "15" ]; then
    echo -e "\uE04F \x05n/a\x05 |\x01"
  else
    echo -e "\uE023 \x02$ac%\x05 |\x01"
  fi
}


free_mem(){
  used_mem="$(awk '/^-/ {print $3}' <(free -m))"
  free_mem="$(awk '/^-/ {print $4}' <(free -m))"
  if [ "$free_mem" -gt "$used_mem" ]
    then
      echo -e "\uE037 \x02$used_mem\x05 MB |\x01"
    else
      echo -e "\uE037 \x06$used_mem\x05 MB |\x01"
    fi
}


# CPU line courtesy Procyon:https://bbs.archlinux.org/viewtopic.php?pid=874333#p874333
cpu_usage(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu_usage="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
  if [ "$cpu_usage" -gt "50" ]; then echo -e "\uE031 \x06$cpu_usage%"; fi
  if [ "$cpu_usage" -le "50" ]; then echo -e "\uE031 \x01$cpu_usage%"; fi
}


cpu_speed() {
  core_speed="$(grep "cpu MHz" /proc/cpuinfo | awk '{ print $4 }' )"
  echo -e "\x05$core_speed |\x01"
}

temperature(){
  cpu_temp="$(sensors | grep "temp1" | cut -c16- | head -c 2)"
  mb_temp="$(sensors | grep "temp2" | cut -c16- | head -c 2)"
  echo -e "\uE00A \x02$cpu_temp\uE010 $mb_temp\uE010\x05 |\x01"
}

hdd_space(){
  hdd_space="$(df -P | sort -d | awk '/^\/dev/{s=s (s?" ":"") $5} END {printf "%s", s}')"
  echo -e "\uE008 \x01$hdd_space\x05 |\x01"
}

mpd() {
    if [ -z "$(mpc status | grep '\[playing\]')"]; then
        output="${PAUSED}"
    else
        output="${PLAYING}"
    fi
    output="${output} `mpc current | cut -c 1-33`"
    echo $output
}

bspwm_info() {
    bspc config top_padding $PANEL_HEIGHT
    bspc control --subscribe
}

window_infO() {
    xtitle -sf 'T%s'
}

window_info
bspwm_info &
while :; do

    if [ -f $BATC ]; then
        echo "B$(battery)"
    fi

    echo "N$(network)"

    echo "V$(volume)"
    echo "D$(clock)"

    echo "M$(mpd)"
    echo "K$(keyboard_indicator)"

    printf "I%s\n" $(whoami)

    sleep 1 # The HUD will be updated every second
done
