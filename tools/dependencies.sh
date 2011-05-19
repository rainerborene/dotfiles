#!/bin/bash
#
# This script updates "manually" some themes and syncronizes
# git submodules. Optionally, you can commit these changes too.

function theme() {
  curl --url $1 -O > /dev/null 2>&1
}

function submodule_do() {
  git submodule foreach git $*
}

cd ~/.dotfiles/vim/colors
echo "*** Updating themes..."
theme "https://github.com/nelstrom/vim-blackboard/raw/master/colors/blackboard.vim"
theme "https://github.com/nelstrom/vim-mac-classic-theme/raw/master/colors/mac_classic.vim"
theme "https://github.com/tpope/vim-vividchalk/raw/master/colors/vividchalk.vim"
theme "https://github.com/joshuaclayton/dotfiles/raw/master/vim/colors/customgithub.vim"
theme "http://blog.toddwerth.com/entry_files/8/ir_black.vim"

echo "*** Updating submodules..."
cd ~/.dotfiles
submodule_do clean -f
submodule_do pull origin master

read -p "Do you want to commit these changes [y/n]?" ANSWER
[ $ANSWER == "y" ] && git commit -a -v -m "Updated themes and submodules."
echo "*** Done"
