ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gozilla"
plugins=(git ruby rails3 vi-mode bundle rbenv cloudapp)

source $ZSH/oh-my-zsh.sh

# Custom options
unsetopt promptcr

# Userful aliases
alias zshconfig='vim ~/.zshrc'
alias ohmyzsh='vim ~/.oh-my-zsh'

# Environment variables
export UNAME=`uname`
export EDITOR='vim'
export LESS="-R"
export CLICOLOR="auto"
export PATH="$HOME/.dotfiles/bin:$HOME/.rbenv/bin:$PATH"

if [[ "$COLORTERM" == "gnome-terminal" ]]; then
  export TERM="gnome-256color"
fi

source $HOME/.dotfiles/zsh/aliases.zsh

# Z command
source $HOME/.dotfiles/zsh/z.sh
precmd() {
  _z --add "$(pwd -P)"
}

# Welcome message
ruby $HOME/.dotfiles/bin/subliminar
