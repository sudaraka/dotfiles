#
# ~/.bash_profile
#

PATH=$HOME/bin:$PATH
PATH=$PATH:$HOME/opt/android-sdk-linux/tools
PATH=$PATH:$HOME/opt/android-sdk-linux/platform-tools
PATH=$PATH:$HOME/opt/heroku-client/bin
PATH=$PATH:$HOME/opt/firefox

export PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ /dev/tty1 = $(tty) ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
    #while true; do
        #read -p 'Start X? (Y/n): '

        #if [ -z "$REPLY" ]; then
            #REPLY="Y"
        #fi

        #case $REPLY in
            #[Yy]) printf '\n'; exec startx ;;
            #[Nn]) break ;;
            #*) printf '%s\n' 'Please answer y or n.' ;;
        #esac
    #done

   exec startx
fi
