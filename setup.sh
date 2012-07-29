#!/usr/bin/env bash
# 
# ~rainerborene dotfiles
# Licensed under the WTFPL License.
#
# Thanks to all folks on GitHub for sharing their dotfiles.
#

DOTIGNORE="README.md install.sh zsh lib sshconfig"

#
# Git must be installed on your machine.
#

if ! type -p git &> /dev/null; then
  echo "What? You don't have Git installed."
  exit 1
fi

#
# Install the dot files into user's home directory.
#

install() {
  # Clone repository and initialize modules
  echo "*** Downloading..."
  rm -Rf ~/.dotfiles \
    && git clone -q git://github.com/rainerborene/dotfiles.git ~/.dotfiles \
    && cd ~/.dotfiles \
    && git submodule update --init > /dev/null 2>&1

  ln -nfs ~/.dotfiles/.gitconfig ~/.gitconfig

  # Create symbolic links
  for name in $(ls ~/.dotfiles); do
    if [ -z "$(echo $DOTIGNORE | grep $name)" ]; then
      rm -Rf ~/.$name && ln -s ~/.dotfiles/$name ~/.$name
    fi
  done

  # Create tmp and spell directories
  mkdir ~/.dotfiles/vim/{tmp,spell}
  mkdir ~/.dotfiles/vim/tmp/{swap,undo,backup}

  # Download portuguese spell file for Vim
  curl --url http://stoa.usp.br/vim/files/-1/7458/pt.utf-8.spl \
    -so ~/.dotfiles/vim/spell/pt.utf-8.spl

  # Copy sshconfig to ssh directory
  mkdir -p ~/.ssh && ln -nfs ~/.dotfiles/sshconfig ~/.ssh/config

  # Done
  echo "*** Installed"
}

#
# Remove dot files directory and config files.
#

uninstall() {
  echo "*** Hahaha, classic!"
  for name in $(ls ~/.dotfiles); do
    [[ -z "$(echo $DOTIGNORE | grep $name)" ]] && rm -Rf ~/.$name
  done
  cd ~ && rm -Rf ~/.dotfiles
  type -p fortune &> /dev/null && echo "\n$(fortune)"
}

#
# Update themes and other files.
#

update() {
  local github="https://raw.github.com"

  echo "*** Updating..."

  cd ~/.dotfiles \
    && git submodule -q foreach git clean -q -f \
    && git submodule -q foreach git pull -q origin master

  read -p "Submodules was successfully updated. Are you sure you want to continue [y/n]? " ANSWER
  [[ $ANSWER == "n" || $ANSWER == "N" ]] && exit

  cd ~/.dotfiles/lib
  curl $github/rupa/z/master/z.sh -Os

  cd ~/.dotfiles/vim/colors
  curl $github/nelstrom/vim-mac-classic-theme/master/colors/mac_classic.vim -Os
  curl $github/joshuaclayton/dotfiles/master/vim/colors/github.vim -Os
  curl $github/sjl/badwolf/master/colors/badwolf.vim -Os
  curl $github/tomasr/molokai/master/colors/molokai.vim -Os
  curl http://blog.toddwerth.com/entry_files/8/ir_black.vim -Os

  cd ~/.dotfiles/vim/autoload
  curl $github/tpope/vim-pathogen/master/autoload/pathogen.vim -Os
  curl $github/tpope/vim-repeat/master/autoload/repeat.vim -Os
}

# Parse arguments
case $1 in
  update) update; exit ;;
  uninstall) uninstall; exit ;;
  install) install; exit ;;
esac
