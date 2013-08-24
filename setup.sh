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


########## Vim configuration ##################################################

echo 'Setup Vim Configuration'
echo

# Remove existing configuration and recreate directories
\rm -fr ~/.vim{,rc} 2>/dev/null
\mkdir -pv ~/.vim/bundle
\mkdir -pv ~/.vim/colors

\ln -sv dotfiles/vimrc ~/.vimrc

# Install Vundle from github
\git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# Make vim use aspell dictionary
\mkdir -pv ~/.vim/bundle/vundle/spell
\ln -sv ../../../../.aspell.en.pws ~/.vim/bundle/vundle/spell/en.utf-8.add

# Install wombat256 color theme
\wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

# Run vim command to install bundles
\vim +BundleInstall +qa

########## Vim configuration ##################################################


########## Bash configuration #################################################

echo 'Setup Bash Configuration'
echo

# Remove existing configuration
\rm -fr ~/.bashrc 2>/dev/null

\ln -sv dotfiles/bashrc ~/.bashrc

echo

########## Bash configuration #################################################


########## Git configuration ##################################################

echo 'Setup Git Configuration'
echo

# Remove existing configuration
\rm -fr ~/.gitconfig 2>/dev/null

\ln -sv dotfiles/gitconfig ~/.gitconfig

echo

########## Git configuration ##################################################


########## GNU Screen configuration ###########################################

echo 'Setup GNU Screen Configuration'
echo

# Remove existing configuration
\rm -fr ~/.screenrc 2>/dev/null

\ln -sv dotfiles/screenrc ~/.screenrc

echo

########## GNU Screen configuration ###########################################
