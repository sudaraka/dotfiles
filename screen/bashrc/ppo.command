# ppo.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/ppo.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

BUNDLE_DIR="`pwd`/src/PPO/Bundle"

alias sbc="cd $BUNDLE_DIR/CommonBundle"
alias sbp="cd $BUNDLE_DIR/PromoBundle"
alias sbt="cd $BUNDLE_DIR/TVBundle"


if [ -z "$NO_COMMON_EDITOR" ];
then
    sbc
    launch_gvim
fi;

sbt
launch_gvim

sbc
g s
