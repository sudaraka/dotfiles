# gearpeers.command: Initialize command window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/gearpeers.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

alias tree="tree -CA --dirsfirst -I 'node_modules*'"

launch_gvim

git s
