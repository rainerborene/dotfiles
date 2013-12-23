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
  echo "*** Downloading..."
  rm -Rf ~/.dotfiles

  git clone -q git://github.com/rainerborene/dotfiles.git ~/.dotfiles

  # Create symbolic links
  link .agignore
  link .ctags
  link .gemrc
  link .gitconfig
  link .hushlogin
  link .irbrc
  link .jshintrc
  link .pryrc
  link .railsrc
  link .tmux.conf
  link .urlview
  link .vimrc
  link .vim

  # Copy sshconfig to ssh directory
  mkdir -p ~/.ssh && ln -nfs ~/.dotfiles/sshconfig ~/.ssh/config

  # Done
  echo "*** Installed"
}

link() {
  ln -nfs ~/.dotfiles/$0 ~/$0
}

install
