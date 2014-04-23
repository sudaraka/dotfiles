# ppo-mobile.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/ppo-mobile.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

cd src/PPO/Bundle

#cd src/PPO/Bundle/AppBundle
#git pull origin master

cd CommonBundle
git_pull_or_fetch_remote_branch;

cd ../MobileBundle
git_pull_or_fetch_remote_branch;

launch_gvim

git status
