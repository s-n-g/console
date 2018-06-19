#!/bin/bash
#
# Based on
#http://docs.slackware.com/howtos:window_managers:keyboard_layout_in_i3
#https://unix.stackexchange.com/questions/12072/how-do-i-get-current-keyboard-layout

#i3status --config ~/.i3status.conf | while :
i3status | while :
do
    read line
    #LG=$(setxkbmap -query | awk '/layout/{print $2}')
    ch=$(xset -q | grep -A 0 'LED' | cut -c59-67 | sed 's/0//g')
    if [ -z "$ch" ];then
        LG=en
    else
        LG=el
    fi
    #if [ $LG == "en" ]
    #then
    #    dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#009E00\" },"
    #else
    #    dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#C60101\" },"
    #fi
    if [ $LG == "en" ]
    then
        #dat="[{ \"full_text\": \"$LG\", \"color\":\"#009E00\" },"
        dat="[{ \"full_text\": \"$LG\", \"color\":\"#FFFFFF\" },"
    else
        dat="[{ \"full_text\": \"$LG\", \"color\":\"#C60101\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
##
##i3status --config ~/.i3status.conf | while :
##do
##        read line
##        LG=$(setxkbmap -query | awk '/layout/{print $2}') 
##        echo "LG: $LG | $line" || exit 1
##done
##
