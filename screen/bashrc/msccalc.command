# msccalc.command: Initialize server window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/msccalc.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

alias tree='tree -C --dirsfirst -I "__pyc*|node_modules*|coverage*"'

pyve msc-calc

launch_gvim

g s
