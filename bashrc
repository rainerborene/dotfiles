source ~/.dotfiles/bash/env
source ~/.dotfiles/bash/config
source ~/.dotfiles/bash/aliases
source ~/.dotfiles/bash/completion

# load functions
source ~/.dotfiles/bash/functions/z.sh
source ~/.dotfiles/bash/functions/tat.sh

# enable rbenv shims and autocompletion
eval "$(rbenv init -)"

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && source ~/.localrc
