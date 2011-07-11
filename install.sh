#!/usr/bin/env bash
# 
# ~rainerborene dotfiles
# Licensed under the WTFPL License.
#
# Thanks to all folks on GitHub for sharing their dotfiles.
#

DOTIGNORE="README.md install.sh bash"

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

  # Global gitignore
  git config --global core.excludesfile ~/.dotfiles/.gitignore
  git config --global color.ui always

  # Create symbolic links
  for name in $(ls ~/.dotfiles); do
    if [ -z "$(echo $DOTIGNORE | grep $name)" ]; then
      rm -Rf ~/.$name && ln -s ~/.dotfiles/$name ~/.$name
    fi
  done

  # Create tmp and spell directories
  mkdir ~/.dotfiles/vim/{tmp,spell}

  # Download portuguese spell file for Vim
  curl --url http://stoa.usp.br/vim/files/-1/7458/pt.utf-8.spl \
    -s -o ~/.dotfiles/vim/spell/pt.utf-8.spl

  # Override bash_profile
  echo "[[ -f ~/.bashrc ]] && source ~/.bashrc" > ~/.bash_profile

  # Compile command-t extension
  echo "*** Compiling extensions..."
  cd ~/.dotfiles/vim/bundle/command-t && rake make > /dev/null 2>&1

  # Done
  echo "*** Installed"
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

  cd ~/.dotfiles/vim/colors
  curl $github/nelstrom/vim-blackboard/master/colors/blackboard.vim -Os
  curl $github/nelstrom/vim-mac-classic-theme/master/colors/mac_classic.vim -Os
  curl $github/tpope/vim-vividchalk/master/colors/vividchalk.vim -Os
  curl $github/joshuaclayton/dotfiles/master/vim/colors/customgithub.vim -Os
  curl http://blog.toddwerth.com/entry_files/8/ir_black.vim -Os

  cd ~/.dotfiles/vim/autoload
  curl $github/tpope/vim-pathogen/master/autoload/pathogen.vim -Os
  curl $github/tpope/vim-repeat/master/autoload/repeat.vim -Os

  cd ~/.dotfiles/bash/bash_completion.d
  curl $github/jweslley/rails_completion/master/rails.bash -Os
}

#
# Install dependencies (these are optionals).
#

dependencies() {
  if ! type -p ack &> /dev/null; then
    # See http://petdance.com/ack/ for more information.
    echo "*** Installing ack..."
    sudo curl --url http://betterthangrep.com/ack-standalone -s -o /usr/local/bin/ack 
    sudo chmod 0755 /usr/local/bin/ack
  fi

  echo "*** Installing gems..."
  sudo gem install -q wirble awesome_print

  echo "*** Done"
}

# Parse arguments
case $1 in
  update) update; exit ;;
  dependencies) dependencies; exit ;;
  install|*) install; exit ;;
esac
