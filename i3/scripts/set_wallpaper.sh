#!/bin/bash
SSIZE=$(xrandr | grep ' connected' | sed '2,$d' | sed -e 's/.* \([0-9][0-9]*x[0-9][0-9]*\)\+.*/\1/')
[ -z "$1" ] || {
    case $1 in
        nitrogen)
            p=$(sed '1d' ~/.config/nitrogen/bg-saved.cfg 2>/dev/null | sed '2,$d')
            pic="${p#file=}"
            convert "$pic" ~/.config/i3/wallpaper.png
            ;;
        *)
            [ -r "$1" ] || exit 1
            convert "$1" ~/.config/i3/wallpaper.png
            ;;
    esac
}
convert ~/.config/i3/wallpaper.png ~/.config/i3/lock.png -gravity center -composite ~/.config/i3/lock-wallpaper.png
