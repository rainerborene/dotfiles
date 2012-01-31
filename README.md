# rainerborene's dotfiles

## Installation

    bash <(curl -# https://raw.github.com/rainerborene/dotfiles/master/setup.sh) install

This will clone this repository and create symlinks for all config files in your 
home directory. After some time you might want to keep updated with the main
repository, you could run the following command inside the dotfiles directory
to sync:

    git pull origin master 

If you'd like to switch your shell from the default `bash` to `zsh`, you can do
so with the following command.

    chsh -s /bin/zsh

Have fun.
