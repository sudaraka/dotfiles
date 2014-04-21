# ppo.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/ppo.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

cd src/PPO/Bundle;

cd CommonBundle;
git_pull_or_fetch_origin_master;

cd ../PromoBundle;
git_pull_or_fetch_origin_master;
git pull origin prf

launch_gvim

git status