#!/bin/sh
#
# setup.sh: install configuration files into current user's environment.
# Author: Sudaraka Wijesinghe
#

echo 'Dotfiles Setup.'
echo '==============='
echo 'Copyright 2013, 2014 Sudaraka Wijesinghe. <sudaraka.org/contact>'
echo 'Creative Commons Attribution 3.0 Unported License.'
echo

DOTFILES_DIR=$(realpath $(dirname $0));

if [ -z "$DOTFILES_DIR" ]; then
  echo 'Unable to determine dotfiles repository.';
  echo 'Check if "realpath" package is missing in your system.'
  exit 1;
fi;

# Vim configuration {{{

echo 'Setup Vim Configuration'
echo

# Remove existing configuration and recreate directories
find ~/.vim/* -maxdepth 0 -name bundle -prune -o -exec rm -fr {} \; 2>/dev/null
rm -fr ~/.vimrc 2>/dev/null
rm -fr ~/.emmetrc 2>/dev/null
mkdir -pv ~/.vim/bundle
mkdir -pv ~/.vim/colors

ln -sv "$DOTFILES_DIR/vimrc" ~/.vimrc
ln -sv "$DOTFILES_DIR/emmet-snippets.json" ~/.emmetrc

# Install Vundle from github
if [ ! -d ~/.vim/bundle/vundle ]; then
   \git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi;

# Make vim use aspell dictionary
mkdir -pv ~/.vim/spell
rm ~/.vim/spell/en.utf-8.add
ln -sv ../../.aspell.en.pws ~/.vim/spell/en.utf-8.add

# Configure molokai color theme
ln -sv ~/.vim/bundle/molokai/colors/molokai.vim ~/.vim/colors/

# Run vim command to install bundles
vim +BundleClean +BundleUpdate +BundleInstall +qa

# Symlink patched font for powerline/airline
sudo mkdir -pv /usr/share/fonts/TTF 2>/dev/null
sudo rm /usr/share/fonts/TTF/DejaVu\ Sans\ Mono\ for\ Powerline.ttf 2>/dev/null
sudo ln -s ~/.vim/bundle/powerline-fonts/DejaVuSansMono/DejaVu\ Sans\ Mono\ for\ Powerline.ttf /usr/share/fonts/TTF

echo

# }}}

# Bash configuration {{{

echo 'Setup Bash Configuration'
echo

# Remove existing configuration
rm -f ~/.bash_profile 2>/dev/null
rm -f ~/.bashrc 2>/dev/null
rm -f ~/.bashrc.local 2>/dev/null
rm -f ~/.signature 2>/dev/null
sudo rm -f /usr/share/bash-completion/completions/cdp 2>/dev/null
sudo rm -f /usr/share/bash-completion/completions/pyve 2>/dev/null

ln -sv "$DOTFILES_DIR/bash_profile" ~/.bash_profile
ln -sv "$DOTFILES_DIR/bashrc" ~/.bashrc
if [ -f $DOTFILES_DIR/bashrc.`uname -n` ]; then
   ln -sv "$DOTFILES_DIR/bashrc.`uname -n`" ~/.bashrc.local
fi;

sudo ln -sv $DOTFILES_DIR/cdp-completion.bash /usr/share/bash-completion/completions/cdp
sudo ln -sv $DOTFILES_DIR/pyve-completion.bash /usr/share/bash-completion/completions/pyve

ln -sv "$DOTFILES_DIR/signature" ~/.signature

echo

# }}}

# Git configuration {{{

echo 'Setup Git Configuration'
echo

# Remove existing configuration
rm -f ~/.gitconfig 2>/dev/null

ln -sv "$DOTFILES_DIR/gitconfig" ~/.gitconfig

mkdir -p ~/bin >/dev/null 2>&1
rm ~/bin/git_vimdiff.sh >/dev/null 2>&1
ln -sv "$DOTFILES_DIR/git_vimdiff.sh" ~/bin/git_vimdiff.sh

echo

# }}}

# GNU Screen configuration {{{

echo 'Setup GNU Screen Configuration'
echo

# Remove existing configuration
rm -f ~/.screen 2>/dev/null
rm -f ~/.screenrc 2>/dev/null
sudo rm -f /usr/share/bash-completion/completions/scr 2>/dev/null

ln -sv "$DOTFILES_DIR/screen" ~/.screen
ln -sv "$DOTFILES_DIR/screenrc" ~/.screenrc

sudo ln -sv $DOTFILES_DIR/scr-completion.bash /usr/share/bash-completion/completions/scr

echo

# }}}

# GUI configuration {{{

echo 'Setup GUI Configuration'
echo

# Remove existing configuration
rm -f ~/.xinitrc 2>/dev/null
rm -f ~/.gtkrc-2.0 2>/dev/null
rm -fr ~/.config/gtk-3.0 2>/dev/null
rm -f ~/.config/Trolltech.conf 2>/dev/null
rm -f ~/.gtk-bookmarks 2>/dev/null
rm -f ~/.i3 2>/dev/null
rm -f ~/.config/dunst/dunstrc 2>/dev/null
rm -f ~/.config/tilda/config_0 2>/dev/null

mkdir -p ~/.config/{dunst,tilda,gtk-3.0} >/dev/null 2>&1

ln -sv "$DOTFILES_DIR/xinitrc" ~/.xinitrc
ln -sv "$DOTFILES_DIR/gtkrc-2.0" ~/.gtkrc-2.0
ln -sv "$DOTFILES_DIR/Trolltech.conf" ~/.config/
ln -sv "$DOTFILES_DIR/gtkrc-3.0" ~/.config/gtk-3.0/settings.ini
if [ -f "$DOTFILES_DIR/gtk-bookmarks.`uname -n`" ]; then
  ln -sv "$DOTFILES_DIR/gtk-bookmarks.`uname -n`" ~/.gtk-bookmarks
else
  ln -sv "$DOTFILES_DIR/gtk-bookmarks" ~/.gtk-bookmarks
fi;

# setup i3wm config and scripts
PRIMARY_DISPLAY=`xrandr|grep '\sconnected'|cut -d' ' -f1|head -n1`;
SECONDARY_DISPLAY=`xrandr|grep 'HDMI'|cut -d' ' -f1|head -n1`;
WIRELESS_INTERFACE=`ip link|grep ': wl'|cut -d':' -f2|tr -d ' '`;
ETHERNET_INTERFACE=`ip link|grep ': en'|cut -d':' -f2|tr -d ' '`;
BATTERY_ID=`find /sys/class/power_supply -type l -name BAT*|xargs basename`
FONT_SIZE=10

case "`xrandr |grep $PRIMARY_DISPLAY|cut -d' ' -f4|cut -d'x' -f1`" in
  1920) FONT_SIZE=12;;
esac

if [ -z "$WIRELESS_INTERFACE" ]; then
  WIRELESS_INTERFACE="wlnx0"
fi;

for file in config conkyrc; do
  rm $DOTFILES_DIR/i3/$file #>/dev/null 2>&1
  cp -v $DOTFILES_DIR/i3/$file{.default,} #>/dev/null 2>&1

  sed "s/%PRIMARY_DISPLAY%/$PRIMARY_DISPLAY/" \
    -i "$DOTFILES_DIR/i3/$file" \
    >/dev/null 2>&1;

  sed "s/%SECONDARY_DISPLAY%/$SECONDARY_DISPLAY/" \
    -i "$DOTFILES_DIR/i3/$file" \
    >/dev/null 2>&1;

  sed "s/%WIRELESS_INTERFACE%/$WIRELESS_INTERFACE/" \
    -i "$DOTFILES_DIR/i3/$file" \
    >/dev/null 2>&1;

  sed "s/%ETHERNET_INTERFACE%/$ETHERNET_INTERFACE/" \
    -i "$DOTFILES_DIR/i3/$file" \
    >/dev/null 2>&1;

  sed "s/%BATTERY_ID%/$BATTERY_ID/" \
    -i "$DOTFILES_DIR/i3/$file" \
    >/dev/null 2>&1;

  sed "s/%FONT_SIZE%/$FONT_SIZE/" \
    -i "$DOTFILES_DIR/i3/$file" \
    >/dev/null 2>&1;
done;

ln -sv "$DOTFILES_DIR/i3" ~/.i3
ln -sv "$DOTFILES_DIR/i3/dunstrc" ~/.config/dunst
ln -sv "$DOTFILES_DIR/i3/tilda" ~/.config/tilda/config_0

mkdir -p ~/bin >/dev/null 2>&1
rm ~/bin/i3exit >/dev/null 2>&1
ln -sv "$DOTFILES_DIR/i3/i3exit" ~/bin/i3exit

# Download "Font Awesome" used for icons in i3wm
rm -f ~/.fonts/FontAwesome.otf >/dev/null 2>&1
rm -f ~/.fonts/fontawesome-webfont.ttf >/dev/null 2>&1
mkdir -p ~/.fonts >/dev/null 2>&1
ln -sv ~/src/Font-Awesome/fonts/FontAwesome.otf ~/.fonts/
ln -sv ~/src/Font-Awesome/fonts/fontawesome-webfont.ttf ~/.fonts/

echo

# }}}

# Dictionary file (aspell) {{{

echo 'Setup Dictionary for Aspell'
echo

# Remove existing configuration
rm -f ~/.aspell.en.pws 2>/dev/null

ln -sv "$DOTFILES_DIR/aspell.en.pws" ~/.aspell.en.pws

echo

# }}}

# Jupyter Notebook {{{

echo 'Setup Jupyter Notebook'
echo

systemctl --user enable "$DOTFILES_DIR/jupyter-notebook.service"

echo

# }}}

# Npm configuration {{{

echo 'Setup Npm Configuration'
echo

# Remove existing configuration
rm -f ~/.npmrc 2>/dev/null

ln -sv "$DOTFILES_DIR/npmrc" ~/.npmrc

echo

# }}}

# JSHint configuration {{{

echo 'Setup JSHint Configuration'
echo

# Remove existing configuration
rm -f ~/.jshintrc 2>/dev/null

ln -sv "$DOTFILES_DIR/jshint.json" ~/.jshintrc

echo

# }}}

# Redis configuration {{{

echo 'Setup Redis Configuration'
echo

# Remove existing configuration
rm ~/opt/redis/etc/default.conf 2>/dev/null

ln -sv "$DOTFILES_DIR/redis/redis.conf" ~/opt/redis/etc/default.conf

systemctl --user enable "$DOTFILES_DIR/redis/redis@.service"

echo

# }}}

# MyCli configuration {{{

echo 'Setup MyCli Configuration'
echo

python -m venv ~/opt/virtualenv/mycli
. ~/opt/virtualenv/mycli/bin/activate
pip install -U pip
pip install -U mycli
deactivate

# Remove existing configuration
rm -f ~/.myclirc 2>/dev/null

ln -sv "$DOTFILES_DIR/myclirc" ~/.myclirc

echo

# }}}

# MongoDB configuration {{{

echo 'Setup MongoDB Configuration'
echo

# Remove existing configuration
rm ~/opt/mongodb/etc/mongod.conf 2>/dev/null

mkdir -pv ~/opt/mongodb/{etc,db}

ln -sv "$DOTFILES_DIR/mondodb/mongodb.conf" ~/opt/mongodb/etc/mongod.conf

systemctl --user enable "$DOTFILES_DIR/mongodb/mongod.service"
rm ~/.config/systemd/user/default.target.wants/mongod.service 2>/dev/null

echo

# }}}
