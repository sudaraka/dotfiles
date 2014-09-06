# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

pyve tkbook

launch_gvim

git s
