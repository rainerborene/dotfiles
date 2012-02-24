ZSH=$HOME/.oh-my-zsh
ZSH_THEME="josh"
plugins=(git ruby rails3 vi-mode bundle rbenv cloudapp)

source $ZSH/oh-my-zsh.sh

# Custom options
unsetopt promptcr

# Userful aliases
alias zshconfig='vim ~/.zshrc'
alias ohmyzsh='vim ~/.oh-my-zsh'

source $HOME/.dotfiles/zsh/aliases.zsh

# Environment variables
export UNAME=`uname`
export EDITOR='vim'
export LESS="-R"
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
export PATH="$HOME/.dotfiles/bin:$HOME/.rbenv/bin:$PATH"
export CLICOLOR="auto"
export RUBY_BIN=`which ruby | sed 's/ruby$//'`

if [[ "$COLORTERM" == "gnome-terminal" ]]; then
  export TERM="gnome-256color"
fi

# Z command
source $HOME/.dotfiles/zsh/z.sh
precmd() {
  _z --add "$(pwd -P)"
}

# Welcome message
ruby $HOME/.dotfiles/bin/subliminar
