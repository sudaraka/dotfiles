#
# ~/.bash_profile
#

PATH=$HOME/bin:$PATH

OPT_DIR="$HOME/opt"

# Node.js and npm paths
NPM_PREFIX="$HOME/.node_modules"
export NODE_PATH="$NPM_PREFIX/lib/node_modules"

# Composer (PHP) settings
export COMPOSER_HOME="$OPT_DIR/composer"
export COMPOSER_CACHE_DIR="$HOME/.cache/composer"

EXTRA_PATH=''
EXTRA_PATH="$EXTRA_PATH $NPM_PREFIX/bin"

# Explicitly defined paths
for dir in $EXTRA_PATH; do
    if [ -d $dir ]; then
        PATH=$PATH:$dir
    fi;
done;

# Find all direct subdirectories of OPT_DIR
for dir in $(find $OPT_DIR/* -maxdepth 0 -type d); do
  # If there is ./bin subdirectory, use it
  if [ -d $dir/bin ]; then
    dir=$dir/bin
  fi

  # Make sure there are executables in the chosen directory
  if [ ! -z "$(find $dir/* -maxdepth 0 -type f -executable)" ]; then
    # Make sure it's not already in $PATH
    if [ "${PATH#*$dir}" == "$PATH" ]; then
      PATH=$PATH:$dir
    fi
  fi
done

export PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ /dev/tty1 = $(tty) ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
   exec startx
fi
