#!/bin/bash
#        _           
# __   _(_)_ __ ___  
# \ \ / / | '_ ` _ \ 
#  \ V /| | | | | | |
#   \_/ |_|_| |_| |_|
#
# My vim life.
# Rainer Borene

# Check if git is installed.
if [ ! -e "/usr/bin/git" ]; then
  echo "What? You don't have Git installed."
  exit 1
fi

# Install ack-grep binary
if [ ! -e "/usr/bin/ack-grep" ]; then
  if [ "$(uname -o)" == "GNU/Linux" ]; then
    echo "*** Installing ack-grep..."
    sudo apt-get install ack-grep
  else
    echo "Sorry, but you have to install ack-grep first."
    exit 1
  fi
fi

TTY="/dev/$( ps -p$$ | tail -1 | awk '{print$2}' )"

# Make sure we want to proceed with installation.
read -p "Old vim files will be lost. Are you sure you want to proceed [y/n]? " ANSWER < $TTY
[ $ANSWER == "y" ] || exit 1

# Remove current vim configuration
cd ~
rm -Rf .vimrc .gvimrc ~/.vim

# Clone repository
echo "*** Downloading..."
git clone git://github.com/rainerborene/vimfiles.git .vim > /dev/null 2>&1
ln -s .vim/.vimrc

# Create tmp directory
cd ~/.vim
mkdir tmp spell
wget --no-check-certificate -O ~/.vim/spell/pt.utf-8.spl http://github.com/rosenfeld/git-spell-pt-br/raw/master/pt.utf-8.spl > /dev/null 2>&1

# Initialize submodules
echo "*** Updating modules..."
git submodule update --init > /dev/null 2>&1

# Compile Command-T extension
echo "*** Compiling extensions..."
cd ~/.vim/bundle/command-t
rake make > /dev/null 2>&1

# Done.
echo "*** Installed"
