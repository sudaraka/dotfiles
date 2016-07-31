#
# ~/.bash_profile
#

PATH=$HOME/bin:$PATH

OPT_DIR="$HOME/opt"

# Composer (PHP) settings
export COMPOSER_HOME="$OPT_DIR/composer"
export COMPOSER_CACHE_DIR="$HOME/.cache/composer"

EXTRA_PATH=''
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/android-sdk-linux/tools"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/android-sdk-linux/platform-tools"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/heroku-client/bin"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/node/bin"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/npm/bin"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/firefox"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/redis/bin"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/HipChat4/bin"
EXTRA_PATH="$EXTRA_PATH $OPT_DIR/GraphiQL"
EXTRA_PATH="$EXTRA_PATH $COMPOSER_HOME"

for dir in $EXTRA_PATH; do
    if [ -d $dir ]; then
        PATH=$PATH:$dir
    fi;
done;

export PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ /dev/tty1 = $(tty) ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
   exec startx
fi
