# wrc.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/wrc.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

http

read -n1 -s -p 'Get off full-screen terminal to launch gvim'
echo ''

pushd web/wp-content >/dev/null
gvim
popd >/dev/null

git status
