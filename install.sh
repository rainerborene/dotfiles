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
if ! type -p git &> /dev/null; then
  echo "What? You don't have Git installed."
  exit 1
fi

# Check if ack is installed.
# See http://petdance.com/ack/ for more information.
if ! type -p ack &> /dev/null; then
  echo "*** Installing ack..."
  sudo curl http://betterthangrep.com/ack-standalone -o /usr/local/bin/ack
  sudo chmod 0755 /usr/local/bin/ack
fi

# Make sure we want to proceed with installation.
read -p "Vim related files will be deleted. Are you sure you want to proceed [y/n]? " ANSWER
[ $ANSWER == "y" ] || exit 1

# Remove current vim configuration
cd ~ && rm -Rf .vimrc .gvimrc ~/.vim

# Clone repository
echo "*** Downloading..."
git clone git://github.com/rainerborene/vimfiles.git .vim > /dev/null 2>&1
ln -s .vim/.vimrc

# Create tmp and spell directories
cd ~/.vim && mkdir tmp spell

# Download spell file
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