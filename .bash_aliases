# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -l'
alias lsd='ls -d'
alias llh='ls -lh'
alias lah='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..="cd .."

# manjaro update
alias 1pkeys='sudo pacman --noconfirm -Sy archlinux-keyring manjaro-keyring ; sudo pacman-key --populate archlinux manjaro ; sudo pacman-key --refresh-keys'
alias 1pwp='sudo pacman-mirrors -f 5; sudo pacman -Syyuw --noconfirm'
alias 1pup='sudo pacman -Su'
