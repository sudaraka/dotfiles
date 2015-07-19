# sopin.command: Initialize server window shell
# Author: Sudaraka Wijesinghe <sudaraka.org/contact>
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/sopin.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

pyve sopin

launch_gvim

git s
