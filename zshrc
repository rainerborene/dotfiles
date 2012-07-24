plugins=(git lol ruby vagrant extract rails3 vi-mode node npm brew bundler rbenv cloudapp heroku)

export ZSH=$HOME/.oh-my-zsh
export UNAME=`uname`
export EDITOR="vim"
export LESS="-R"
export CLICOLOR="auto"
export PORT="5000"
export RACK_ENV="development"
export DISABLE_AUTO_TITLE="true"
export PATH=/usr/local/mysql/bin:$PATH
unsetopt promptcr

source $ZSH/oh-my-zsh.sh

# Custom theme
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$ '

# Dependencies
source $HOME/.dotfiles/lib/z.sh

# Useful aliases
source $HOME/.dotfiles/zsh/misc.zsh
source $HOME/.dotfiles/zsh/ruby.zsh
source $HOME/.dotfiles/zsh/git.zsh

# Z command
precmd() {
  _z --add "$(pwd -P)"
}

# Login message
_welcome
