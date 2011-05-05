# rainerborene's dotfiles

## Installation

    $ curl https://github.com/rainerborene/dotfiles/raw/master/install.sh | bash

This will clone this repository and create symlinks for all config files in your 
home directory. You can run the below commands to update.

    $ cd ~/.dotfiles/
    $ git pull origin master
    $ git submodule foreach git pull origin master

And you're done.
