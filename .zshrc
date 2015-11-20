# Essentials {{{

BASE=$HOME/.dotfiles
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
UPDATE_ZSH_DAYS=13
ZSH=$HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh.git
ZSH_THEME="robbyrussell"

plugins=(git git-extras z history-substring-search)

source $ZSH/oh-my-zsh.sh

# }}}
# Environment variables {{{

export EDITOR=nvim
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g "" 2>/dev/null'
export FZF_DEFAULT_OPTS='--extended --cycle --no-256 --bind "ctrl-z:toggle"'
export GEM_HOME=$HOME/.gem/ruby/2.2.0/
export GOPATH=$HOME/go
export LESS='-R --silent'
export NVIM_PATH=$HOME/Projects/neovim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export PATH=$BASE/bin:$HOME/.gem/ruby/2.2.0/bin:$NVIM_PATH/build/bin:./bin/:$PATH:$GOPATH/bin
export VIMRUNTIME=$NVIM_PATH/runtime/

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

alias g='git'
alias j='z'
alias la='ls -la'
alias ls='exa --group-directories-first'
alias l='tree --dirsfirst -ChaFL 1'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

alias o='command xdg-open $ARGV >/dev/null 2>&1'
alias oo='xdg-open (pwd) >/dev/null 2>&1'
alias pbc='xclip -selection clipboard'
alias pbp='xclip -selection clipboard -o'

alias be='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias fore='foreman start -f Procfile.dev'

# }}}
# Functions {{{

# }}}
# Key mappings {{{

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# }}}
# FZF {{{

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# }}}
