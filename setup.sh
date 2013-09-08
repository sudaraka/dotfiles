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

########## Vim configuration ##################################################

echo 'Setup Vim Configuration'
echo

# Remove existing configuration and recreate directories
\rm -fr ~/.vim{,rc} 2>/dev/null
\mkdir -pv ~/.vim/bundle
\mkdir -pv ~/.vim/colors

\ln -sv "$DOTFILES_DIR/vimrc" ~/.vimrc

# Install Vundle from github
\git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Make vim use aspell dictionary
\mkdir -pv ~/.vim/bundle/vundle/spell
\ln -sv ../../../../.aspell.en.pws ~/.vim/bundle/vundle/spell/en.utf-8.add

# Install wombat256 color theme
\wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

# Run vim command to install bundles
\vim +BundleInstall +qa

# Symlink patched font for powerline
\sudo rm /usr/share/fonts/TTF/DejaVu\ Sans\ Mono\ for\ Powerline.ttf 2>/dev/null
\sudo ln -s ~/.vim/bundle/powerline-fonts/DejaVuSansMono/DejaVu\ Sans\ Mono\ for\ Powerline.ttf /usr/share/fonts/TTF

########## Vim configuration ##################################################


########## Bash configuration #################################################

echo 'Setup Bash Configuration'
echo

# Remove existing configuration
\rm -fr ~/.bashrc 2>/dev/null

\ln -sv "$DOTFILES_DIR/bashrc" ~/.bashrc

echo

########## Bash configuration #################################################


########## Git configuration ##################################################

echo 'Setup Git Configuration'
echo

# Remove existing configuration
\rm -fr ~/.gitconfig 2>/dev/null

\ln -sv "$DOTFILES_DIR/gitconfig" ~/.gitconfig

echo

########## Git configuration ##################################################


########## GNU Screen configuration ###########################################

echo 'Setup GNU Screen Configuration'
echo

# Remove existing configuration
\rm -fr ~/.screenrc 2>/dev/null

\ln -sv "$DOTFILES_DIR/screenrc" ~/.screenrc

echo

########## GNU Screen configuration ###########################################


########## X init configuration ###############################################

echo 'Setup X init Configuration'
echo

# Remove existing configuration
\rm -fr ~/.xinitrc 2>/dev/null

\ln -sv "$DOTFILES_DIR/xinitrc" ~/.xinitrc

echo

########## X init configuration ###############################################
