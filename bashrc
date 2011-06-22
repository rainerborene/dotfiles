source ~/.dotfiles/bash/env
source ~/.dotfiles/bash/config
source ~/.dotfiles/bash/aliases
source ~/.dotfiles/bash/completions

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && source ~/.localrc
