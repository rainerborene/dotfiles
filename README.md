# ~rainerborene's dotfiles

## Installation

    bash <(curl -# https://raw.github.com/rainerborene/dotfiles/master/setup.sh) install

This will clone this repository and create symlinks for all config files in your 
home directory. After some time you might want to keep updated with the main
repository, you could run the following command inside the dotfiles directory
to sync:

    git pull origin master 

If you'd like to switch your shell from the default `bash` to `fish`, you can do
so with the following command.

    chsh -s /usr/local/bin/fish

Now set up your credentials.

    git config --global user.name "Jonh Doe"
    git config --global user.email jonh@doe.com

## What plugins are included?

- [vim-fugitive](https://github.com/tpope/vim-fugitive): a Git wrapper so awesome, it should be illegal
- [vim-surround](https://github.com/tpope/vim-surround): quoting/parenthesizing made simple
- [vim-javascript](https://github.com/pangloss/vim-javascript): Vastly improved vim's javascript indentation.
- [vim-markdown](https://github.com/plasticboy/vim-markdown): Markdown Vim Mode
- [ack.vim](https://github.com/mileszs/ack.vim): Vim plugin for the Perl module / CLI script 'ack'
- [vim-sparkup](https://github.com/kogakure/vim-sparkup): Bundled vim version of Sparkup, clone into .vim/bundle (pathogen needed)
- [vim-matchit](https://github.com/edsono/vim-matchit): git repository for a vim plugin called matchit
- [vim-rails](https://github.com/tpope/vim-rails): Ruby on Rails power tools
- [vim-endwise](https://github.com/tpope/vim-endwise): wisely add "end" in ruby, endfunction/endif/more in vim script, etc
- [gundo.vim](https://github.com/sjl/gundo.vim): A git mirror of gundo.vim
- [vim-unimpaired](https://github.com/tpope/vim-unimpaired): pairs of handy bracket mappings
- [vim-commentary](https://github.com/tpope/vim-commentary): comment stuff out
- [vim-bundler](https://github.com/tpope/vim-bundler): Lightweight support for Ruby's Bundler
- [tabular](https://github.com/godlygeek/tabular): Vim script for text filtering and alignment
- [vim-slim](https://github.com/slim-template/vim-slim): A clone of the slim vim plugin from stonean. For use with Pathogen.
- [ctrlp.vim](https://github.com/kien/ctrlp.vim): Fuzzy file, buffer, mru, tag, etc finder.
- [vim-abolish](https://github.com/tpope/vim-abolish): easily search for, substitute, and abbreviate multiple variants of a word
- [vim-haml](https://github.com/tpope/vim-haml): Vim runtime files for Haml, Sass, and SCSS
- [syntastic](https://github.com/scrooloose/syntastic): Syntax checking hacks for vim
- [vim-less](https://github.com/groenewege/vim-less): vim syntax for LESS (dynamic CSS)
- [vim-rake](https://github.com/tpope/vim-rake): it's like rails.vim without the rails'
- [html5.vim](https://github.com/othree/html5.vim): HTML5 omnicomplete and syntax 
- [vim-smartinput](https://github.com/kana/vim-smartinput): Provide smart input assistant
- [clam.vim](https://github.com/sjl/clam.vim): A lightweight Vim plugin for working with shell commands.
- [vim-ruby](https://github.com/vim-ruby/vim-ruby): Vim/Ruby Configuration Files
- [vim-eunuch](https://github.com/tpope/vim-eunuch): helpers for UNIX
- [vim-repeat](https://github.com/tpope/vim-repeat): enable repeating supported plugin maps with "."
- [badwolf](https://github.com/sjl/badwolf): A Vim color scheme.
- [vim-pipe](https://github.com/krisajenkins/vim-pipe): Send a vim buffer through a command and instantly see the output.
- [vim-pathogen](https://github.com/tpope/vim-pathogen): manage your runtimepath
- [vim-scriptease](https://github.com/tpope/vim-scriptease): A Vim plugin for Vim plugins
- [vim-rsi](https://github.com/tpope/vim-rsi): Readline style insertion
- [vim-sleuth](https://github.com/tpope/vim-sleuth): Heuristically set buffer options
- [switch.vim](https://github.com/AndrewRadev/switch.vim): A simple Vim plugin to switch segments of text with predefined replacements
- [vim-dispatch](https://github.com/tpope/vim-dispatch): asynchronous build and test dispatcher
- [vim-tbone](https://github.com/tpope/vim-tbone): tmux basics
- [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object): Vim plugin that defines a new text object representing lines of code at the same indent level. Useful for python/vim scripts, etc.
- [supertab](https://github.com/ervandew/supertab): Perform all your vim insert mode completions with Tab
- [vim-yankstack](https://github.com/nickstenning/vim-yankstack): A lightweight implementation of emacs's kill-ring for vim
- [vim-ragtag](https://github.com/tpope/vim-ragtag): ghetto HTML/XML mappings (formerly allml.vim)
- [vim-sensible](https://github.com/tpope/vim-sensible): Defaults everyone can agree on

## License

`:help license`
