# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.bashrc

cd scraper

pyve blackout

launch_gvim

#git s
