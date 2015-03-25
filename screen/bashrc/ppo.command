# ppo.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/ppo.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias sbc='cd ../CommonBundle'
alias sbp='cd ../PromoBundle'

. ~/.bashrc

BUNDLE_DIR="`pwd`/src/PPO/Bundle"

alias sbc="cd $BUNDLE_DIR/CommonBundle"
alias sbp="cd $BUNDLE_DIR/PromoBundle"


sbc;
CURRENT_BRANCH="`git branch|grep '^\*'|cut -d' ' -f2`"

git_pull_or_fetch_remote_branch

if [ "master" != "$CURRENT_BRANCH" -a ! -z "`git config branch.$CURRENT_BRANCH.remote`" ]; then
    git_pull_or_fetch_remote_branch origin $CURRENT_BRANCH
fi

if [ -z "$NO_COMMON_EDITOR" ];
then
    launch_gvim

    g s
fi;

sbp;
CURRENT_BRANCH="`git branch|grep '^\*'|cut -d' ' -f2`"

git_pull_or_fetch_remote_branch

if [ "master" != "$CURRENT_BRANCH" -a ! -z "`git config branch.$CURRENT_BRANCH.remote`" ]; then
    git_pull_or_fetch_remote_branch origin $CURRENT_BRANCH
fi

launch_gvim

g s
