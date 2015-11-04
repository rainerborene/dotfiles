# vim: set foldmethod=marker :
# Basic setup {{{

BASE=$HOME/.dotfiles
ZSH=$HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh.git
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
UPDATE_ZSH_DAYS=13
DISABLE_AUTO_TITLE="true"

plugins=(git git-extras z history-substring-search)

source $ZSH/oh-my-zsh.sh
source $BASE/.zsh/base16-ocean.dark.sh

# }}}
# Environment variables {{{

export EDITOR=nvim
export NEOVIM=$HOME/Projects/neovim
export PATH=$BASE/bin:$HOME/.gem/ruby/2.2.0/bin:$NEOVIM/build/bin:./bin/:$PATH
export VIMRUNTIME=$NEOVIM/runtime/
export GEM_HOME=$HOME/.gem/ruby/2.2.0/
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g "" 2>/dev/null'
export FZF_DEFAULT_OPTS='--extended --cycle --inline-info --no-256 --bind "ctrl-z:toggle"'
export LESS='-R --silent'

# }}}
# Options {{{

setopt no_beep
setopt hist_ignore_dups
setopt histignorealldups

# }}}
# Aliases {{{

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias ls='ls --color=auto --group-directories-first'
alias l='tree --dirsfirst -ChaFL 1'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias g='git'
alias j='z'
alias be='bundle exec'
alias fore='foreman start -f Procfile.dev'

# }}}
# Key mappings {{{

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# }}}
# Fuzzy finder {{{

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# }}}
