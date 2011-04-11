#!/bin/bash
#        _           
# __   _(_)_ __ ___  
# \ \ / / | '_ ` _ \ 
#  \ V /| | | | | | |
#   \_/ |_|_| |_| |_|
#
# My vim life.
# Rainer Borene

# Check if Git is installed.
if [ ! -e "/usr/bin/git" ]
then
  echo "What? You don't have Git installed."
  exit 1
fi

TTY="/dev/$( ps -p$$ | tail -1 | awk '{print$2}' )"

# Make sure we want to proceed with installation.
read -p "Old vim files will be lost. Are you sure you want to proceed [y/n]? " ANSWER < $TTY
[ $ANSWER == "y" ] || exit 1

# Remove current vim configuration
cd ~
rm -Rf .vimrc .gvimrc ~/.vim

# Clone repository
echo "*** Installing Vimfiles..."
git clone git://github.com/rainerborene/vimfiles.git .vim > /dev/null 
ln -s .vim/.vimrc

# Create tmp directory
cd ~/.vim
mkdir tmp

# Initialize submodules
echo "*** Updating submodules..."
git submodule update --init > /dev/null

# Compile Command-T extension
echo "*** Compiling extensions..."
cd ~/.vim/bundle/command-t
rake make > /dev/null

# Done.
echo "*** Installed"
