source ~/.dotfiles/bash/env
source ~/.dotfiles/bash/config
source ~/.dotfiles/bash/aliases
source ~/.dotfiles/bash/completion

# load functions
source ~/.dotfiles/bash/functions/z.sh

# this loads rvm into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && source ~/.localrc
