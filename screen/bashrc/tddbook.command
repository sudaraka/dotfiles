# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

pyve tddbook

launch_gvim

git sh
