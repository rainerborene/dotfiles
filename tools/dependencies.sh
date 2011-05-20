#!/bin/bash
#
# This script updates "manually" some themes and syncronizes
# git submodules. Optionally, you can commit these changes too.

function vim_plugin_task() {
  curl --url $1 -O > /dev/null 2>&1
}

function git_sm() {
  git submodule foreach git $*
}

cd ~/.dotfiles/vim/colors
echo "*** Updating themes..."
vim_plugin_task "https://github.com/nelstrom/vim-blackboard/raw/master/colors/blackboard.vim"
vim_plugin_task "https://github.com/nelstrom/vim-mac-classic-theme/raw/master/colors/mac_classic.vim"
vim_plugin_task "https://github.com/tpope/vim-vividchalk/raw/master/colors/vividchalk.vim"
vim_plugin_task "https://github.com/joshuaclayton/dotfiles/raw/master/vim/colors/customgithub.vim"
vim_plugin_task "http://blog.toddwerth.com/entry_files/8/ir_black.vim"

cd ~/.dotfiles/vim/autoload
vim_plugin_task "https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim"
vim_plugin_task "https://github.com/tpope/vim-repeat/raw/master/autoload/repeat.vim"

echo "*** Updating submodules..."
cd ~/.dotfiles
git_sm clean -f
git_sm pull origin master

read -p "Do you want to commit these changes [y/n]? " ANSWER
[ $ANSWER == "y" ] && git commit -a -v -m "Updated themes and submodules."
echo "*** Done"
