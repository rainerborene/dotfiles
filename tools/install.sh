#!/bin/bash
# 
# ~rainerborene dotfiles
# Licensed under the WTFPL License.

# Check if git is installed.
if ! type -p git &> /dev/null; then
  echo "What? You don't have Git installed."
  exit 1
fi

# Check if ack is installed.
# See http://petdance.com/ack/ for more information.
if ! type -p ack &> /dev/null; then
  echo "*** Installing ack..."
  sudo curl http://betterthangrep.com/ack-standalone -o /usr/local/bin/ack > /dev/null 2>&1
  sudo chmod 0755 /usr/local/bin/ack
fi

# Make sure we want to proceed with installation.
read -p "Some config files will be overwritten. Are you sure you want to proceed [y/n]? " ANSWER
[ $ANSWER == "y" ] || exit 1

# Clone repository
echo "*** Downloading..."
rm -Rf ~/.dotfiles && git clone git://github.com/rainerborene/dotfiles.git .dotfiles > /dev/null 2>&1

# Remove files and create symlinks
rm -Rf ~/.vim && ln -s ~/.dotfiles/vim/ .vim
for config in $(cd ~/.dotfiles && ls *rc *.conf); do
  rm -Rf ~/.$config && ln -s ~/.dotfiles/$config ~/.$config
done

# Override bash profile file
cat << END > ~/.bash_profile
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
END

# Create tmp and spell directories
cd ~/.dotfiles/vim && mkdir tmp spell

# Download portuguese spellfile
cd ~/.dotfiles/vim/spell/ 
curl -O http://github.com/rosenfeld/git-spell-pt-br/raw/master/pt.utf-8.spl > /dev/null 2>&1

# Initialize submodules
echo "*** Updating modules..."
cd ~/.dotfiles
git submodule update --init > /dev/null 2>&1

# Compile Command-T extension
echo "*** Compiling extensions..."
cd ~/.dotfiles/vim/bundle/command-t
rake make > /dev/null 2>&1

# Done.
echo "*** Installed"
