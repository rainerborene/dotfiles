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

Most of the packages I use on my computer. Make sure to insert archlinuxfr on
pacman mirrorlist.

install with `pacman`

- alsa-utils
- ctags
- dfc
- dropbox
- feh
- firefox
- fish
- git
- gvfs
- gvim
- lightdm
- lightdm-gtk-greeter
- mpv
- openssh
- pass
- redshift
- ristretto
- rxvt-unicode
- skype
- the_silver_searcher
- thunar
- thunar-archive-plugin
- thunar-media-tags-plugin
- thunar-volman
- tree
- tumbler
- urxvt-perls
- wpa_supplicant
- xdg-user-dirs
- xorg-server
- xorg-server-utils
- xorg-xev
- zathura
- zathura-pdf-poppler

install with `yaourt`

- bdf-tewi-git
- compton
- dmenu2
- gtk-theme-arc-git
- i3blocks
- i3-gaps-git
- j4-dmenu-desktop
- thunar-dropbox
- ttf-ms-win8
- ttf-opensans
- urxvt-vtwheel
- vertex-icons-git
- xcape
- xcwd-git
- xtitle-git
