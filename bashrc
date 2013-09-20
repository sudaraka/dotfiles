#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ls='ls -alh --color=auto'
alias sysup='yaourt -Syua'
alias tree='tree -CA'
alias truecrypt='truecrypt -t'
alias vim='vim -g'

PS1="\[\e[0;33m\]\u@\h\[\e[1;92m\] \W\[\e[0;92m\] \$\[\e[0m\] "

export EDITOR=vim
export HISTFILESIZE=99999
export TERM=xterm-256color

#iBus settings
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XIM_PROGRAM=/usr/bin/ibus-daemon
export XMODIFIERS=@im=ibus

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
