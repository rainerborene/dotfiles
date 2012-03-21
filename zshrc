export ZSH=$HOME/.oh-my-zsh
export DISABLE_AUTO_TITLE="true"
plugins=(git ruby rails3 vi-mode node brew bundler rbenv cloudapp heroku)

source $ZSH/oh-my-zsh.sh

# Custom options
unsetopt promptcr

# Custom theme
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$ '

# Userful aliases
alias zshconfig='vim ~/.zshrc'
alias ohmyzsh='vim ~/.oh-my-zsh'

# Environment variables
export UNAME=`uname`
export EDITOR='vim'
export LESS="-R"
export CLICOLOR="auto"
export PATH="$HOME/.dotfiles/bin:$HOME/.rbenv/bin:$PATH"
source $HOME/.dotfiles/zsh/aliases.zsh
source $HOME/.dotfiles/bin/z.sh

# Z command
precmd() {
  _z --add "$(pwd -P)"
}

# Welcome message
ruby $HOME/.dotfiles/bin/subliminar
