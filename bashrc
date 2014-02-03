#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ls='ls -alh --color=auto --group-directories-first'
alias sysup='yaourt -Syua'
alias tree='tree -CA'
alias truecrypt='truecrypt -t'
alias gitk='gitk --all'
alias gitg='gitk --all'

PS1="\[\e[0;33m\]\u@\h\[\e[1;92m\] \W\[\e[0;92m\] \$\[\e[0m\] "

export EDITOR=vim
export HISTFILESIZE=99999
export TERM=xterm-256color

#iBus settings
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XIM_PROGRAM=/usr/bin/ibus-daemon
export XMODIFIERS=@im=ibus

# Invoke GNU screen using extended configuration file
# Based on article by Joseph McCullough
# http://vertstudios.com/blog/multiple-screenrc-configurations-gnu-screen-tutorial/
function scr() {
    if [ ! -f $HOME/.screen/$1 ]; then
        echo "'$1' is not found in $HOME/.screen";
        return 1;
    else
        \screen -c $HOME/.screen/$1
    fi;
}

# switch to the specified python environment installed in ~/.virtualenv
function pyve() {
    if [ -z "$1" ]; then
        echo
        echo 'Usage: pyve <environment_name>';
        echo

        return 1;
    fi;

    if [ ! -d "$HOME/.virtualenv/$1" ]; then
        echo
        echo "Python virtual environment $1 not found.";
        echo

        return 2;
    fi;

    if [ ! -f "$HOME/.virtualenv/$1/bin/activate" ]; then
        echo
        echo "$1 is not a valid python virtual environment.";
        echo

        return 3;
    fi;

    source $HOME/.virtualenv/$1/bin/activate

    return 0;
}

# Fetch or pull the master branch, depending on which branch is the current
function git_pull_or_fetch_origin_master() {
    if [ -z "`git branch|grep '* master'`" ]; then
        git fetch origin master
    else
        git pull origin master
    fi;
}

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
