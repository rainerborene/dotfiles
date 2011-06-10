#!/usr/bin/env bash
# 
# ~rainerborene dotfiles
# Licensed under the WTFPL License.

CURRENT_DIR=$(pwd)
DOTIGNORE=(README.md install.sh bash)

# Git must be installed on your machine.
if ! type -p git &> /dev/null; then
  echo "What? You don't have Git installed."
  exit 1
fi

#
# Install the dot files into user's home directory.
#

function install() {
  # Make sure we want to proceed with installation
  read -p "Are you sure you want to proceed [y/n]? " ANSWER
  [[ $ANSWER == "y" ]] || exit 1

  # Clone repository and initialize modules
  echo "*** Downloading..."
  rm -Rf ~/.dotfiles \
    && git clone -q git://github.com/rainerborene/dotfiles.git ~/.dotfiles \
    && cd ~/.dotfiles \
    && git submodule -q update --init

  # Create symbolic links
  for name in ~/.dotfiles; do
    if [ -z "$(echo $DOTIGNORE | grep $name)" ]; then
      rm -Rf ~/.$name && ln -s ~/.dotfiles/$config ~/.$config
    fi
  done

  # Create tmp and spell directories
  mkdir ~/.dotfiles/vim/{tmp,spell}

  # Download portuguese spell file for Vim
  curl --url http://stoa.usp.br/vim/files/-1/7458/pt.utf-8.spl \
    -o ~/.dotfiles/vim/spell/ 

  # Override bash_profile
  echo "[[ -f ~/.bashrc ]] && source ~/.bashrc" > ~/.bash_profile

  # Compile command-t extension
  echo "*** Compiling extensions..."
  rake -f ~/.dotfiles/vim/bundle/command-t/Rakefile -q make

  # Done
  echo "*** Installed"
}

#
# Update themes and other files.
#

function update() {
  cd ~/.dotfiles \
    && git submodule -q foreach git clean -f \
    && git submodule -q foreach git pull -q origin master

  echo "*** Updating..."
  cd ~/.dotfiles/vim/colors
  curl https://github.com/nelstrom/vim-blackboard/raw/master/colors/blackboard.vim -Oq
  curl https://github.com/nelstrom/vim-mac-classic-theme/raw/master/colors/mac_classic.vim -Oq
  curl https://github.com/tpope/vim-vividchalk/raw/master/colors/vividchalk.vim -Oq
  curl https://github.com/joshuaclayton/dotfiles/raw/master/vim/colors/customgithub.vim -Oq
  curl http://blog.toddwerth.com/entry_files/8/ir_black.vim -Oq

  cd ~/.dotfiles/vim/autoload
  curl https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim -Oq
  curl https://github.com/tpope/vim-repeat/raw/master/autoload/repeat.vim -Oq
}

#
# Install ack.
#

function install_ack() {
  # See http://petdance.com/ack/ for more information.
  if ! type -p ack &> /dev/null; then
    echo "*** Installing ack..."
    curl --url http://betterthangrep.com/ack-standalone -q -o /usr/local/bin/ack 
    sudo chmod 0755 /usr/local/bin/ack
  fi
}

# Parse arguments
case $1 in
  install) install; exit ;;
  update) update; exit ;;
  ack) install_ack; exit ;;
  *) install; exit ;;
esac

# Back to where we was before.
cd $CURRENT_DIR
