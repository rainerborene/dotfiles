# Environment variables
# --------------------------------------------------------------------

source ~/.fish_profile

set -gx fish_greeting
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx ASDF_DATA_DIR $HOME/.asdf
set -gx DOCKER_API_VERSION 1.43

fish_add_path "/usr/bin"
fish_add_path "/usr/local/bin"
fish_add_path "/usr/local/share/npm/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.fzf/bin"
fish_add_path "$HOME/.atuin/bin"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.opencode/bin"
fish_add_path "$HOME/.config/yarn/global/node_modules/.bin"
fish_add_path "$ASDF_DATA_DIR/shims"


# Aliases
# --------------------------------------------------------------------

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias j 'z'
alias g 'git'
alias la 'ls -la'
alias ls 'eza --group-directories-first'
alias l 'tree --dirsfirst -ChaFL 1'
alias top 'btop'
alias vim 'nvim'
alias vi 'nvim'
alias v 'nvim'
alias open 'wsl-open'
alias pbcopy 'xsel --clipboard --input'
alias pbpaste 'xsel --clipboard --output'
alias be 'bundle exec'
alias rc 'rails console'
alias rs 'rails server'
alias cx 'claude'
alias dkk 'docker kill (docker ps -q)'
alias rmzone 'find . -name "*:Zone.Identifier" -delete'

abbr oc 'opencode'

function dkrm -d "Delete docker images by given name"
  docker images | grep $argv | awk '{ print $1 ":" $2 }' | xargs docker rmi
end


# Package managers
# --------------------------------------------------------------------

flox activate -d ~ | source

### unset LD_AUDIT to fix shared library loading error
set -e LD_AUDIT


# Zoxide
# --------------------------------------------------------------------

zoxide init fish | source


# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------

set -x FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
set -x FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"
set -x FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --border"
set -x FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --follow --exclude .git'
set -x FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {}' | head -200'"
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_DEFAULT_OPTS "\
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4"

function fco -d "Fuzzy-find and checkout a branch"
  git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)" | read -z branches;
  set branch (printf '%s' $branches | fzf -d (math 2 + (echo "$branches" | wc -l)) +m)
  test -n "$branch"; and git checkout (echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
end

function fe -d "Open the selected file with the default editor"
  set -l file (fzf --query="$argv[1]" --select-1 --exit-0)
  test -n "$file"; and nvim $file
end

fzf --fish | source


# Wezterm
# --------------------------------------------------------------------

wezterm shell-completion --shell fish | source


# Vivid
# --------------------------------------------------------------------

set -x LS_COLORS (vivid generate catppuccin-mocha)


# Atuin
# --------------------------------------------------------------------

atuin init fish | source


# Asdf
# --------------------------------------------------------------------

asdf completion fish | source
