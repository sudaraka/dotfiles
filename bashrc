#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -alh --color=auto'
alias tree='tree -CA'
alias grep='grep --color=auto'

PS1="\[\e[0;33m\]\u@\h\[\e[1;92m\] \W\[\e[0;92m\] \$\[\e[0m\] "

export EDITOR=vim
export TERM=xterm-256color
export HISTFILESIZE=99999

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
