# ppo.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/ppo.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

BUNDLE_DIR="`pwd`/src/PPO/Bundle"

alias sbc="pushd $BUNDLE_DIR/CommonBundle"
alias sbp="pushd $BUNDLE_DIR/PromoBundle"
alias sbt="pushd $BUNDLE_DIR/TVBundle"
alias g=hub

export GITHUB_USER=sudavc

launch_gvim
g s
