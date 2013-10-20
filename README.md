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

Create a symbolic to `private.xml` for [KeyRemap4MacBook](https://pqrs.org/macosx/keyremap4macbook/) custom settings.

    ln -nfs ~/.dotfiles/private.xml ~/Library/Application\ Support/KeyRemap4MacBook/private.xml

## What plugins are included?

- [ack.vim](https://github.com/mileszs/ack.vim): Vim plugin for the Perl module / CLI script 'ack'
- [badwolf](https://github.com/sjl/badwolf): A Vim color scheme.
- [clam.vim](https://github.com/sjl/clam.vim): A lightweight Vim plugin for working with shell commands.
- [ctrlp.vim](https://github.com/kien/ctrlp.vim): Fuzzy file, buffer, mru, tag, etc finder.
- [gundo.vim](https://github.com/sjl/gundo.vim): A git mirror of gundo.vim
- [html5.vim](https://github.com/othree/html5.vim): HTML5 omnicomplete and syntax
- [linediff.vim](https://github.com/AndrewRadev/linediff.vim): A vim plugin to perform diffs on blocks of code
- [supertab](https://github.com/ervandew/supertab): Perform all your vim insert mode completions with Tab
- [switch.vim](https://github.com/AndrewRadev/switch.vim): A simple Vim plugin to switch segments of text with predefined replacements
- [syntastic](https://github.com/scrooloose/syntastic): Syntax checking hacks for vim
- [tabular](https://github.com/godlygeek/tabular): Vim script for text filtering and alignment
- [tern_for_vim](https://github.com/marijnh/tern_for_vim): Tern plugin for Vim
- [vim-abolish](https://github.com/tpope/vim-abolish): easily search for, substitute, and abbreviate multiple variants of a word
- [vim-bundler](https://github.com/tpope/vim-bundler): Lightweight support for Ruby's Bundler
- [vim-commentary](https://github.com/tpope/vim-commentary): comment stuff out
- [vim-dispatch](https://github.com/tpope/vim-dispatch): asynchronous build and test dispatcher
- [vim-endwise](https://github.com/tpope/vim-endwise): wisely add "end" in ruby, endfunction/endif/more in vim script, etc
- [vim-eunuch](https://github.com/tpope/vim-eunuch): helpers for UNIX
- [vim-fugitive](https://github.com/tpope/vim-fugitive): a Git wrapper so awesome, it should be illegal
- [vim-haml](https://github.com/tpope/vim-haml): Vim runtime files for Haml, Sass, and SCSS
- [vim-indent-object](https://github.com/michaeljsmith/vim-indent-object): Vim plugin that defines a new text object representing lines of code at the same indent level. Useful for python/vim scripts, etc.
- [vim-javascript](https://github.com/pangloss/vim-javascript): Vastly improved vim's javascript indentation.
- [vim-less](https://github.com/groenewege/vim-less): vim syntax for LESS (dynamic CSS)
- [vim-markdown](https://github.com/plasticboy/vim-markdown): Markdown Vim Mode
- [vim-matchit](https://github.com/edsono/vim-matchit): git repository for a vim plugin called matchit
- [vim-pathogen](https://github.com/tpope/vim-pathogen): manage your runtimepath
- [vim-pipe](https://github.com/krisajenkins/vim-pipe): Send a vim buffer through a command and instantly see the output.
- [vim-powerline](https://github.com/Lokaltog/vim-powerline): The ultimate vim statusline utility.
- [vim-ragtag](https://github.com/tpope/vim-ragtag): ghetto HTML/XML mappings (formerly allml.vim)
- [vim-rails](https://github.com/tpope/vim-rails): Ruby on Rails power tools
- [vim-rake](https://github.com/tpope/vim-rake): it's like rails.vim without the rails'
- [vim-repeat](https://github.com/tpope/vim-repeat): enable repeating supported plugin maps with "."
- [vim-rsi](https://github.com/tpope/vim-rsi): Readline style insertion
- [vim-ruby](https://github.com/vim-ruby/vim-ruby): Vim/Ruby Configuration Files
- [vim-scriptease](https://github.com/tpope/vim-scriptease): A Vim plugin for Vim plugins
- [vim-sensible](https://github.com/tpope/vim-sensible): Defaults everyone can agree on
- [vim-sleuth](https://github.com/tpope/vim-sleuth): Heuristically set buffer options
- [vim-slim](https://github.com/slim-template/vim-slim): A clone of the slim vim plugin from stonean. For use with Pathogen.
- [vim-smartinput](https://github.com/kana/vim-smartinput): Provide smart input assistant
- [vim-sneak](https://github.com/justinmk/vim-sneak): The missing motion for Vim
- [vim-sparkup](https://github.com/rstacruz/sparkup): A parser for a condensed HTML format
- [vim-surround](https://github.com/tpope/vim-surround): quoting/parenthesizing made simple
- [vim-unimpaired](https://github.com/tpope/vim-unimpaired): pairs of handy bracket mappings

## License

`:help license`
