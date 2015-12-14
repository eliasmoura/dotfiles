#!/bin/sh

case "$1" in
    "toggle")
        mpc "toggle"
        ;;
    "stop")
        mpc "stop"
        ;;
    "next")
        mpc "next"
        ;;
    "prev")
        mpc "prev"
        ;;
esac

sh "~/.config/dzen2/scripts/mpd.sh"
