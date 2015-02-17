# ~dotfiles

## Installation

    curl https://raw.githubusercontent.com/rainerborene/dotfiles/master/setup.sh | bash

This will clone this repository and create symlinks for all config files in your
home directory. After some time you might want to keep updated with the main
repository, you could run the following command inside the dotfiles directory
to sync:

    git pull origin master

If you'd like to switch your shell from the default `bash` to `fish`, you can do
so with the following command.

    chsh -s $(which fish)

Now set up your credentials.

    git config --global user.name "Jonh Doe"
    git config --global user.email jonh@doe.com

## What I use

- bspwm
- sxhkd
- dmenu2
- compton
- feh
- scrot
- urxvt
- tmux
- vim
- the_silver_searcher
- j4-dmenu-desktop
- simplescreenrecorder
