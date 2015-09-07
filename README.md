# ~dotfiles

## Installation

Make sure you're on home directory before running these commands.

```bash
git clone https://github.com/rainerborene/dotfiles.git .dotfiles

# link the config files you want with the command:
ln -s .dotfiles/.{vimrc,agignore} .
```

## Defaults

If you'd like to switch your shell from the default `bash` to `fish`, you can do
so with the following command.

    chsh -s $(which fish)

Now set up your credentials.

    git config --global user.name "Jonh Doe"
    git config --global user.email jonh@doe.com

## Packages

Here are the main packages I use on my computer.

install with `pacman`

- alsa-utils
- dropbox
- feh
- firefox
- fish
- git
- gvfs (for automounting and trash)
- gvim
- lightdm
- lightdm-gtk-greeter
- networkmanager
- network-manager-applet
- openssh
- pass
- rxvt-unicode
- scrot
- skype
- the_silver_searcher
- thunar
- thunar-volman
- tmux
- tree
- unzip
- urxvt-perls
- vlc
- xdg-user-dirs
- xorg-server
- xorg-server-utils
- xorg-xev

install with `yaourt`

- bdf-tewi-git
- compton
- dmenu2
- exa-git
- gtk-theme-arc-git
- i3blocks
- i3-gaps-git
- i3lock-wrapper
- j4-dmenu-desktop
- thunar-dropbox
- ttf-ms-win8
- ttf-opensans
- urxvt-vtwheel
- vertex-icons-git
- xcape
- xcwd-git
- xtitle-git

Note: make sure to insert archlinuxfr on pacman mirrorlist.
