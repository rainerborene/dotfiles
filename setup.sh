#!/usr/bin/env bash
# vim: set fdm=marker fmr={,} :

DOTIGNORE="README.md install.sh fish mutt sshconfig gitmodules"

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
    && git --git-dir ~/.dotfiles/.git submodule update --init > /dev/null 2>&1

  # Create symbolic links
  for name in $(find ~/.dotfiles -type f -depth 1 -exec basename "{}" \;); do
    if [ -z "$(echo $DOTIGNORE | grep $name)" ]; then
      rm -Rf ~/$name && ln -s ~/.dotfiles/$name ~/$name
    fi
  done

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
  for name in $(find ~/.dotfiles -type f -depth 1 -exec basename "{}" \;); do
    [[ -z "$(echo $DOTIGNORE | grep $name)" ]] && rm -Rf ~/$name
  done
  rm -Rf ~/.dotfiles
}

# Parse arguments
case $1 in
  install) install; exit ;;
  uninstall) uninstall; exit ;;
esac
