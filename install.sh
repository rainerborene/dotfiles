#!/usr/bin/env bash
# vim: set fdm=marker fmr={,} :

#
# Git must be installed on your machine.
#

if ! type -p git &>/dev/null; then
  echo "Git is required."
  exit 1
fi

#
# Install the dot files into user's home directory.
#

install() {
  # Clone repository and initialize modules
  echo "dotfiles: downloading..."
  rm -Rf ~/.dotfiles

  git clone -q git://github.com/rainerborene/dotfiles.git ~/.dotfiles

  # Create symbolic links
  dotlink curlrc
  dotlink ptignore
  dotlink ctags
  dotlink gemrc
  dotlink gitconfig
  dotlink hushlogin
  dotlink irbrc
  dotlink jshintrc
  dotlink pryrc
  dotlink railsrc
  dotlink tmux.conf
  dotlink vimrc
  dotlink vimperatorrc
  dotlink Xresources

  # Create directories
  mkdir -p ~/.ssh
  mkdir -p ~/.config/fish

  # Manual linking
  ln -nfs ~/.dotfiles/vim ~/.vim
  ln -nfs ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish
  ln -nfs ~/.dotfiles/sshconfig ~/.ssh/config

  # Setup vim
  echo "dotfiles: installing vim package manager"
  mkdir ~/.dotfiles/vim/bundle
  git clone -q https://github.com/junegunn/vim-plug.git ~/.dotfiles/vim/bundle/vim-plug

  # Done
  echo "dotfiles: installed"
}

dotlink() {
  echo "dotfiles: linking .$1"
  ln -nfs ~/.dotfiles/.$1 ~/.$1
}

install
