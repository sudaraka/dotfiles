#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias ls='ls -alh --color=auto --group-directories-first'
alias sysup='yaourt -Syua'
alias tree='tree -C --dirsfirst -I "__pyc*|node_modules*"'
alias truecrypt='truecrypt -t'
alias g='git'
alias n='npm'
alias gg='gitk --all --date-order'
alias cdd="pushd $DOWNLOADSDIR >/dev/null"
alias vbm='sudo modprobe vboxdrv && sudo modprobe vboxpci && sudo modprobe vboxnetadp && sudo modprobe vboxnetflt'
alias mycli='~/opt/virtualenv/mycli/bin/mycli'

# Make GIT completion work with "g" alias
# Based on Stackoverflow answer by chris_sutter and Ondrej Machulda
# https://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases
source /usr/share/git/completion/git-completion.bash
__git_complete g __git_main

# Enable Npm completion for both `npm` an `n` alias
source $HOME/opt/npm/etc/bash_completion
complete -o default -F _npm_completion n

# Frequently used directories
export DOWNLOADSDIR="$HOME/downloads"
export PROJECTSDIR="$HOME/projects"
export PYVEDIR="$HOME/opt/virtualenv"

PROMPT_COMMAND=set_cli_prompt

export EDITOR=vim
export TERM=xterm-256color

# History
export HISTFILESIZE=999999
export NODE_REPL_HISTORY_FILE=$HOME/.node_history
export NODE_REPL_HISTORY_SIZE=999999

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

# Make directory in $1 if not exists and `cd` into it
function mcd() {
    DIR=$1

    if [ ! -d $DIR ]; then
        mkdir -p $DIR >/dev/null 2>&1

        if [ 0 -ne $? ]; then
            echo "Unable to create $DIR"
            exit 1
        fi
    fi

    cd $DIR
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

# update all packages in python virtual environments
function pyve-update() {
    TARGET=$1
    shift

    DIR_BASE=`basename $PYVEDIR`
    VE_LIST=`find $PYVEDIR/ -maxdepth 1 -type d ! -name "$DIR_BASE" -printf '%f\n'`

    for ve in $VE_LIST; do
        echo "Switching to virtualenv $ve"
        pyve $ve

        which pip >/dev/null 2>&1
        if [ 0 -ne $? ]; then
            echo 'No pip!'
        else
            echo 'Updating pip...'
            pip install --disable-pip-version-check -U pip

            if [ "all" == "$TARGET" -o "$TARGET" == "$ve" ]; then
                PACKAGES=`pip --disable-pip-version-check -q freeze|cut -d'=' -f1`
                if [ ! -z "$PACKAGES" ]; then
                    echo 'Updating packages...'
                    pip install --disable-pip-version-check -U $PACKAGES
                fi
            fi
        fi

        deactivate
        echo ''
    done
}

# Fetch or pull the given branch, depending on which branch is the current
function git_pull_or_fetch_remote_branch() {
    REMOTE=$1
    shift
    BRANCH=$1

    if [ -z "$REMOTE" ]; then REMOTE='origin'; fi;
    if [ -z "$BRANCH" ]; then BRANCH='master'; fi;

    if [ -z "`git branch|grep \"* $BRANCH\"`" ]; then
        git fetch $REMOTE $BRANCH
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

alias_of() {
    echo $(alias "$1" 2>/dev/null | awk -F= '{ print $2 }' | sed s/\'//g)
}

# Update CLI prompt
set_cli_prompt() {
    BG=236

    # Ending
    P="\[\e[0;38;5;$(( BG + 2 ));48;5;${BG}m\]\[\e[0;38;5;${BG}m\]\[\e[0m\] "
    BG=$(( BG + 2 ))

    # Working directory
    P="\[\e[0;38;5;$(( BG + 2));48;5;${BG}m\]\[\e[38;5;249m\] \W $P"
    BG=$(( BG + 2 ))

    # Git branch
    GIT_BRANCH=`git status 2>/dev/null|head -n1|awk '{print $(NF)}'`
    if [ ! -z "$GIT_BRANCH" ]; then
        GIT_BLOCK=''
        GIT_TAG=`git describe --tags --abbrev=0 2>/dev/null`

        if [ ! -z "$GIT_TAG" ]; then
            GIT_BLOCK=" \[\e[0;38;5;$(( BG + 2 ));48;5;${BG}m\] \[\e[38;5;229m\]\[\e[38;5;249m\] $GIT_TAG$GIT_BLOCK"
            BG=$(( BG + 2 ))
        fi

        GIT_BLOCK="\[\e[0;38;5;$(( BG + 2 ));48;5;${BG}m\] \[\e[38;5;208m\]\[\e[38;5;249m\] $GIT_BRANCH$GIT_BLOCK"
        BG=$(( BG + 2 ))

        if [ -z "`git status 2> /dev/null | grep 'working directory clean'`" ]; then
            GIT_BLOCK="$GIT_BLOCK\[\e[38;5;226m\] ⚡"
        fi

        P="$GIT_BLOCK $P"
    fi

    # Python virtual environment
    if [ ! -z "$VIRTUAL_ENV" ]; then
        P="\[\e[0;38;5;$(( BG + 2 ));48;5;${BG}m\]\[\e[38;5;45m\] `basename $VIRTUAL_ENV` $P"
        BG=$(( BG + 2 ))
    fi

    # Starting block
    P="\[\e[48;5;107m\] \[\e[38;5;107;48;5;${BG}m\]$P"

    PS1=$P
}

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
