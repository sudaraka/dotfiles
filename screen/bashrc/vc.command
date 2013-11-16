# vc.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/vc.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

cd src/PPO/Bundle

#cd src/PPO/Bundle/AppBundle
#git pull origin master

cd CommonBundle
git pull origin master

cd ../MobileBundle
if [ -z "`git branch|grep '* master'`" ]; then
    git fetch origin master
else
    git pull origin master
fi;
git status
