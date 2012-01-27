. ~/.dotfiles/zsh/env
. ~/.dotfiles/zsh/config
. ~/.dotfiles/zsh/aliases
. ~/.dotfiles/zsh/completion

# load functions
source ~/.dotfiles/zsh/functions/_z

# enable rbenv shims and autocompletion
eval "$(rbenv init -)"

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc
