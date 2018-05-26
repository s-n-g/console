# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases_private ]; then
    . ~/.bash_aliases_private
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$HOME"/bin:/usr/local/bin:"$PATH"
export EDITOR=vim
export GNUPGHOME="/home/spiros/.gnupg"
export VDPAU_DRIVER=nvidia
export BOOKSHELF=/home/spiros/projects/Lazarus/doc/


#############################################
#       GIMP STUFF
#############################################
export GEGL_USE_OPENCL=no
export GEGL_SWAP=RAM
export MALLOC_MMAP_MAX_=200000
export MALLOC_MMAP_THRESHOLD_=128*1024
#############################################

function youn(){
    if [ -z "$1" ];then _youhelp;return;fi
    if [ "$1" = "-F" ];then youtube-dl -F "$2";return;fi
    if [ -z "$3" ];then
        netbrake -r "$1" youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -o '%(title)s.%(ext)s'  "$2"
    else
        netbrake -r "$1" youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -o '%(title)s.%(ext)s'  -f "$2" "$3"
    fi
}
function you(){
    if [ -z "$1" ];then _youhelp;return;fi
    if [ "$1" = "-F" ];then youtube-dl -F "$2";return;fi
    if [ -z "$2" ];then
        youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0'  -o '%(title)s.%(ext)s' "$1"
    else
        youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0'  -o '%(title)s.%(ext)s' -f "$1" "$1"
    fi
}
function youd(){
    if [ -z "$1" ];then _youhelp;return;fi
    if [ "$1" = "-F" ];then youtube-dl -F "$2";return;fi
    if [ -z "$2" ];then
        youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -o '%(upload_date)s - %(title)s.%(ext)s' "$1"
    else
        youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -o '%(upload_date)s - %(title)s.%(ext)s' -f "$1" "$2"
    fi
}
function yound(){
    if [ -z "$1" ];then _youhelp;return;fi
    if [ "$1" = "-F" ];then youtube-dl -F "$2";return;fi
    if [ -z "$3" ];then
        netbrake -r "$1" youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -o '%(upload_date)s - %(title)s.%(ext)s' "$2"
    else
        netbrake -r "$1" youtube-dl --user-agent 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' -o '%(upload_date)s - %(title)s.%(ext)s' -f "$2" "$3"
    fi
}
function _youhelp(){
cat <<EOF
    youn [bandwidth limit] <-f> [URL]
    yound [bandwidth limit] <-f> [URL]
    youd <-f> [URL]
    you <-f> [URL]
EOF
}
#############################################################################
# pandoc
#############################################################################
function pan2pdf(){
#pandoc test2.md -o test2.pdf --latex-engine=xelatex --template=my.latex --variable mainfont="DejaVu Serif" --variable sansfont=Arial
[ -z "$1" ] && {
    echo "Usage: pan2pdf [file]"
    return
}
local OUT
OUT="${1%.*}".pdf
pandoc --pdf-engine=xelatex --variable mainfont="DejaVu Serif" "$1" -o "$OUT"
}
#############################################################################
# End of pandoc
#############################################################################
#############################################################################
# ImageMagic
#############################################################################
function new_image(){
[ -z "$3" ] && {
    echo "Usage: new_image [size] [color] [file_name]"
    return
}
convert -size "$1" xc:"$2" "$3"
}
function new_transparent_image(){
[ -z "$2" ] && {
    echo "Usage: new_transparent_image [size] [file_name]"
    return
}
convert -size "$1" xc:white xx$$.png
convert xx$$.png -transparent white "$2"
}
#############################################################################
# End ImageMagic
#############################################################################
#############################################################################
# pdftk
#############################################################################
function pdfcompress(){
[ -z "$1" ] && {
    echo "Usage: pdfcompress [PDF File]"
    return
}
pdftk "$1" output "$(echo "$1" | sed 's/\.pdf$/-compressed.pdf/')" compress
}
function pdfuncompress(){
[ -z "$1" ] && {
    echo "Usage: pdfuncompress [PDF File]"
    return
}
pdftk "$1" output "$(echo "$1" | sed 's/\.pdf$/-uncompressed.pdf/')" uncompress
}
#############################################################################
# End of pdftk
#############################################################################


# powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

## vi mode for command line
#set -o vi

# autojump
. /etc/profile.d/autojump.bash

#-------- Color Manpages
export LESS_TERMCAP_mb=$'\E[01;31m'             # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'             # begin bold
export LESS_TERMCAP_me=$'\E[0m'                 # end mode
export LESS_TERMCAP_se=$'\E[0m'                 # end standout-mode                 
export LESS_TERMCAP_so=$'\E[01;44;33m'          # begin standout-mode - info box                              
export LESS_TERMCAP_ue=$'\E[0m'                 # end underline
export LESS_TERMCAP_us=$'\E[01;32m'             # begin underline
#export MANPAGER="/usr/bin/most -s"             # color using most
