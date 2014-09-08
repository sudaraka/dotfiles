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
alias g='git'
alias gk='gitk --all --date-order'
alias gg='gitk --all --date-order'
alias cdd="pushd $DOWNLOADSDIR >/dev/null"
alias cdv="pushd $VAULTDIR >/dev/null"
alias vbm='sudo modprobe vboxdrv && sudo modprobe vboxpci && sudo modprobe vboxnetadp && sudo modprobe vboxnetflt'

# Make GIT completion work with "g" alias
# Based on Stackoverflow answer by chris_sutter and Ondrej Machulda
# https://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases
source /usr/share/git/completion/git-completion.bash
__git_complete g __git_main

# Frequently used directories
export DOWNLOADSDIR="$HOME/downloads"
export PROJECTSDIR="$HOME/projects"
export VAULTDIR="$HOME/vault"

PS1="\[\e[0;33m\]\u@\h\[\e[1;92m\] \W\[\e[0;92m\] \$\[\e[0m\] "

export EDITOR=vim
export HISTFILESIZE=99999
export TERM=xterm-256color

# iBus settings
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XIM_PROGRAM=/usr/bin/ibus-daemon
export XMODIFIERS=@im=ibus

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

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

# Switch to the project working directory
function cdp() {
    DIR=$1

    if [ ! -d $PROJECTSDIR/$DIR ]; then
        echo "Directory not found: $PROJECTSDIR/$DIR";
        return 1;
    else
        pushd $PROJECTSDIR/$DIR >/dev/null
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

    if [ ! -d "$HOME/opt/virtualenv/$1" ]; then
        echo
        echo "Python virtual environment $1 not found.";
        echo

        return 2;
    fi;

    if [ ! -f "$HOME/opt/virtualenv/$1/bin/activate" ]; then
        echo
        echo "$1 is not a valid python virtual environment.";
        echo

        return 3;
    fi;

    source $HOME/opt/virtualenv/$1/bin/activate

    return 0;
}

# Fetch or pull the given branch, depending on which branch is the current
function git_pull_or_fetch_remote_branch() {
    REMOTE=$1
    shift
    BRANCH=$1

    if [ -z "$REMOTE" ]; then REMOTE='origin'; fi;
    if [ -z "$BRANCH" ]; then BRANCH='master'; fi;

    if [ -z "`git branch|grep \"* $BRANCH\"`" ]; then
        git fetch $REMOTE $BRANCH:$BRANCH
    else
        git pull $REMOTE $BRANCH
    fi;
}

# Launch gvim from current directory
function launch_gvim() {
    echo 'NOTE: Make sure the terminal is not full-screen when gvim is launched.'
    read -n1 -s -p 'Start gvim? (Y/n)' GVIM
    echo ''

    if [ -z "$GVIM" -o "$GVIM" = "Y" -o "$GVIM" = "y" ];
    then
        gvim
    fi;
}

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
