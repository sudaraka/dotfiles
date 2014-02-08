#!/bin/sh
#
# setup.sh: install configuration files into current user's environment.
# Author: Sudaraka Wijesinghe
#

echo 'Dotfiles Setup.'
echo '==============='
echo 'Copyright 2013 Sudaraka Wijesinghe. <sudaraka.org/contact>'
echo 'Creative Commons Attribution 3.0 Unported License.'
echo

DOTFILES_DIR=$(realpath $(dirname $0));

# Vim configuration {{{

echo 'Setup Vim Configuration'
echo

# Remove existing configuration and recreate directories
\find ~/.vim/* -maxdepth 0 -name bundle -prune -o -exec rm -fr {} \; 2>/dev/null
\rm -fr ~/.vimrc 2>/dev/null
\mkdir -pv ~/.vim/bundle
\mkdir -pv ~/.vim/colors

\ln -sv "$DOTFILES_DIR/vimrc" ~/.vimrc

# Install Vundle from github
if [ ! -d ~/.vim/bundle/vundle ]; then
    \git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi;

# Make vim use aspell dictionary
\mkdir -pv ~/.vim/bundle/vundle/spell
\rm ~/.vim/bundle/vundle/spell/en.utf-8.add
\ln -sv ../../../../.aspell.en.pws ~/.vim/bundle/vundle/spell/en.utf-8.add

# Install wombat256 color theme
\wget -nv -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

# Run vim command to install bundles
\vim +BundleClean +BundleUpdate +BundleInstall +qa

# Symlink patched font for powerline/airline
\sudo mkdir -pv /usr/share/fonts/TTF 2>/dev/null
\sudo rm /usr/share/fonts/TTF/DejaVu\ Sans\ Mono\ for\ Powerline.ttf 2>/dev/null
\sudo ln -s ~/.vim/bundle/powerline-fonts/DejaVuSansMono/DejaVu\ Sans\ Mono\ for\ Powerline.ttf /usr/share/fonts/TTF

echo

# }}}

# Bash configuration {{{

echo 'Setup Bash Configuration'
echo

# Remove existing configuration
\rm -f ~/.bash_profile 2>/dev/null
\rm -f ~/.bashrc 2>/dev/null
\rm -f ~/.bashrc.local 2>/dev/null

\ln -sv "$DOTFILES_DIR/bash_profile" ~/.bash_profile
\ln -sv "$DOTFILES_DIR/bashrc" ~/.bashrc
if [ -f $DOTFILES_DIR/bashrc.`uname -n` ]; then
    \ln -sv "$DOTFILES_DIR/bashrc.`uname -n`" ~/.bashrc.local
fi;

echo

# }}}

# Git configuration {{{

echo 'Setup Git Configuration'
echo

# Remove existing configuration
\rm -f ~/.gitconfig 2>/dev/null

\ln -sv "$DOTFILES_DIR/gitconfig" ~/.gitconfig

echo

# }}}

# GNU Screen configuration {{{

echo 'Setup GNU Screen Configuration'
echo

# Remove existing configuration
\rm -f ~/.screen 2>/dev/null
\rm -f ~/.screenrc 2>/dev/null

\ln -sv "$DOTFILES_DIR/screen" ~/.screen
\ln -sv "$DOTFILES_DIR/screenrc" ~/.screenrc

echo

# }}}

# GUI configuration {{{

echo 'Setup GUI Configuration'
echo

# Remove existing configuration
\rm -f ~/.xinitrc 2>/dev/null
\rm -f ~/.gtkrc-2.0 2>/dev/null
\rm -f ~/.config/gtk-3.0 2>/dev/null
\rm -f ~/.config/Trolltech.conf 2>/dev/null
\rm -f ~/.gtk-bookmarks 2>/dev/null
\rm -f ~/.i3 2>/dev/null
\rm -f ~/.config/twmn/twmn.conf 2>/dev/null

\mkdir -p ~/.config/twmn >/dev/null 2>&1

\ln -sv "$DOTFILES_DIR/xinitrc" ~/.xinitrc
\ln -sv "$DOTFILES_DIR/gtkrc-2.0" ~/.gtkrc-2.0
\ln -sv "$DOTFILES_DIR/Trolltech.conf" ~/.config/
\ln -sv ~/src/numix-holo/gtk-3.0 ~/.config/
if [ -f "$DOTFILES_DIR/gtk-bookmarks.`uname -n`" ]; then
    \ln -sv "$DOTFILES_DIR/gtk-bookmarks.`uname -n`" ~/.gtk-bookmarks
fi;

\mkdir -p ~/bin >/dev/null 2>&1

MAIN_DISPLAY=`xrandr|grep '\sconnected'|head -n1|cut -d' ' -f1`;
\sed "s/^\(set \$display0 \).\+$/\1$MAIN_DISPLAY/" \
    -i "$DOTFILES_DIR/i3/config" >/dev/null 2>&1;

\ln -sv "$DOTFILES_DIR/i3" ~/.i3
\ln -sv "$DOTFILES_DIR/i3/i3exit" ~/bin/i3exit
\ln -sv "$DOTFILES_DIR/i3/twmn.conf" ~/.config/twmn

echo

# }}}

# Dictionary file (aspell) {{{

echo 'Setup Dictionary for Aspell'
echo

# Remove existing configuration
\rm -f ~/.aspell.en.pws 2>/dev/null

\ln -sv "$DOTFILES_DIR/aspell.en.pws" ~/.aspell.en.pws

echo

# }}}
