# ~dotfiles

See NeoVim config on `.config/nvim/init.vim` file.

## Installation

Make sure you're on home directory before running these commands.

```bash
$ git clone https://github.com/rainerborene/dotfiles.git .dotfiles
$ ln -s .dotfiles/.{pryrc,agignore,...} .
```

Now set up your credentials.

```bash
$ git config --global user.name "Jonh Doe"
$ git config --global user.email jonh@doe.com
```

## Run URxvt directly from VBS

```VisualBasic
dim objShell
set objShell=wscript.createObject("WScript.Shell")
iReturnCode=objShell.Run("plink -load virtualbox -pw borene -t /home/rainerborene/.dotfiles/bin/terminal",0,TRUE)
```

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
- git
- gvfs
- lightdm
- lightdm-gtk-greeter
- mpv
- nodejs
- openssh
- pass
- redshift
- ristretto
- skype
- the_silver_searcher
- thunar
- thunar-archive-plugin
- thunar-media-tags-plugin
- thunar-volman
- tree
- ttf-ubuntu-font-family
- tumbler
- urxvt-perls
- words
- wpa_supplicant
- xdg-user-dirs
- xorg-server
- xorg-server-utils
- xorg-xev
- zathura
- zathura-pdf-poppler
- zsh

install with `yaourt`

- bdf-tewi-git
- compton
- dmenu2
- exa-git
- gtk-theme-arc-git
- i3blocks
- i3-gaps-git
- j4-dmenu-desktop
- neovim-git
- otf-font-awesome
- rust-nightly-bin
- rxvt-unicode-24bit
- thunar-dropbox
- tmux-24bit-color
- ttf-ms-win8
- ttf-opensans
- urxvt-vtwheel
- vertex-icons-git
- xcape
- xcwd-git
- xtitle-git
