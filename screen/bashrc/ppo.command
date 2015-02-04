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

cd src/PPO/Bundle;

cd CommonBundle;
git_pull_or_fetch_remote_branch;

if [ -z "$NO_COMMON_EDITOR" ];
then
    launch_gvim

    g s
fi;

cd ../PromoBundle;
git_pull_or_fetch_remote_branch;

launch_gvim

g s
