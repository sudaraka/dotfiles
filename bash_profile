#
# ~/.bash_profile
#

PATH=$HOME/bin:$PATH

OPT_DIRS=''
OPT_DIRS="$OPT_DIRS android-sdk-linux/tools"
OPT_DIRS="$OPT_DIRS android-sdk-linux/platform-tools"
OPT_DIRS="$OPT_DIRS heroku-client/bin"
OPT_DIRS="$OPT_DIRS node/bin"
OPT_DIRS="$OPT_DIRS io.js/bin"
OPT_DIRS="$OPT_DIRS firefox"

for dir in $OPT_DIRS; do
    if [ -d $HOME/opt/$dir ]; then
        PATH=$PATH:$HOME/opt/$dir
    fi;
done;

export PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ /dev/tty1 = $(tty) ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
   exec startx
fi
