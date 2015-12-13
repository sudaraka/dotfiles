# flapi.command: Initialize server window shell
# Author: [Sudaraka Wijesinghe](https://sudaraka.org/contact)
# Source: https://github.com/sudaraka/dotfiles/blob/master/screen/bashrc/flapi.command
# License: CC-BY
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

alias tree="tree -C --dirsfirst -I '__pyc*|coverage*|node_modules*|_build*'"
alias supervisorctl='supervisorctl -c etc/supervisord-dev.conf'

pyve flapi

launch_gvim

g s
