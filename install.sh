#!/usr/bin/env bash
# 
# ~rainerborene dotfiles
# Licensed under the WTFPL License.

DOTIGNORE="README.md install.sh bash"

# Git must be installed on your machine.
if ! type -p git &> /dev/null; then
  echo "What? You don't have Git installed."
  exit 1
fi

#
# Install the dot files into user's home directory.
#

function install () {
  # Clone repository and initialize modules
  echo "*** Downloading..."
  rm -Rf ~/.dotfiles \
    && git clone -q git://github.com/rainerborene/dotfiles.git ~/.dotfiles \
    && cd ~/.dotfiles \
    && git submodule update --init > /dev/null 2>&1

  # Create symbolic links
  for name in `ls ~/.dotfiles`; do
    if [ -z "$(echo $DOTIGNORE | grep $name)" ]; then
      rm -Rf ~/.$name && ln -s ~/.dotfiles/$name ~/.$name
    fi
  done

  # Create tmp and spell directories
  mkdir ~/.dotfiles/vim/{tmp,spell}

  # Download portuguese spell file for Vim
  curl --url http://stoa.usp.br/vim/files/-1/7458/pt.utf-8.spl \
    -s -o ~/.dotfiles/vim/spell/

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

function update() {
  cd ~/.dotfiles \
    && git submodule -q foreach git clean -q -f \
    && git submodule -q foreach git pull -q origin master

  echo "*** Updating..."
  cd ~/.dotfiles/vim/colors
  curl https://raw.github.com/nelstrom/vim-blackboard/master/colors/blackboard.vim -Os
  curl https://raw.github.com/nelstrom/vim-mac-classic-theme/master/colors/mac_classic.vim -Os
  curl https://raw.github.com/tpope/vim-vividchalk/master/colors/vividchalk.vim -Os
  curl https://raw.github.com/joshuaclayton/dotfiles/master/vim/colors/customgithub.vim -Os
  curl http://blog.toddwerth.com/entry_files/8/ir_black.vim -Os

  cd ~/.dotfiles/vim/autoload
  curl https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -Os
  curl https://raw.github.com/tpope/vim-repeat/master/autoload/repeat.vim -Os
}

#
# Install ack.
#

function install_ack() {
  # See http://petdance.com/ack/ for more information.
  if ! type -p ack &> /dev/null; then
    echo "*** Installing ack..."
    curl --url http://betterthangrep.com/ack-standalone -s -o /usr/local/bin/ack 
    sudo chmod 0755 /usr/local/bin/ack
  fi
}

# Parse arguments
case $1 in
  ack) install_ack; exit ;;
  update) update; exit ;;
  install|*) install; exit ;;
esac
