plugins=(git ruby rails3 vi-mode node brew bundler rbenv cloudapp heroku)

export ZSH=$HOME/.oh-my-zsh
export DISABLE_AUTO_TITLE="true"
source $ZSH/oh-my-zsh.sh
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

# Useful aliases
source $HOME/.dotfiles/zsh/ruby.zsh
source $HOME/.dotfiles/zsh/misc.zsh
source $HOME/.dotfiles/zsh/git.zsh

# Environment variables
export UNAME=`uname`
export EDITOR="vim"
export LESS="-R"
export CLICOLOR="auto"
export PATH="$HOME/.dotfiles/bin:$PATH"

# Dependencies
source $HOME/.dotfiles/bin/z.sh

# Z command
precmd() {
  _z --add "$(pwd -P)"
}

# Login message
ruby $HOME/.dotfiles/bin/subliminar
