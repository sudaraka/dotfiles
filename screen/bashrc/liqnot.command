# liqnot.command: Initialize server window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/liqnot.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

alias tree='tree -CAI __*'

pyve liqnot

launch_gvim

git status

git sh
