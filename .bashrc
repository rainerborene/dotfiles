# System default
# --------------------------------------------------------------------

[ -f /etc/bashrc ] && . /etc/bashrc


# Options
# --------------------------------------------------------------------

### Append to the history file
shopt -s histappend

### Check the window size after each command ($LINES, $COLUMNS)
shopt -s checkwinsize

### Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

### Correct spelling errors in arguments supplied to cd
shopt -s cdspell

### Autocorrect on directory names to match a glob.
shopt -s dirspell

### Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar

### Better-looking less for binary files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

### Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

### Disable CTRL-S and CTRL-Q
[[ $- =~ i ]] && stty -ixoff -ixon

### Allow C-W mapping in inputrc to work
stty werase undef


# Environment variables
# --------------------------------------------------------------------

### History opts
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
[ -z "$TMPDIR" ] && TMPDIR=/tmp

### Global
if [ -z "$PATH_EXPANDED" ]; then
  export ASDF_DATA_DIR="$HOME/.asdf"
  export PATH="$ASDF_DATA_DIR/shims:$HOME/.local/bin:/usr/local/bin:$PATH"
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  export PATH_EXPANDED=1
fi
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

### fzf
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --border"
export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' | head -200'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

[ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'


# Aliases
# --------------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias j='z'
alias g='git'
alias la='ls -la'
alias ls='eza --group-directories-first'
alias l='tree --dirsfirst -ChaFL 1'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias open='xdg-open &>/dev/null'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias be='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias fore='foreman start -f Procfile.dev'
alias dkk='docker kill $(docker ps -q)'
alias rmzone='find . -name "*:Zone.Identifier" -delete'

dkrm() {
  docker images | grep $@ | awk '{ print $1 ":" $2 }' | xargs docker rmi
}


# Package managers
# --------------------------------------------------------------------

### Cargo
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

### Activate default Flox environment only within the current shell
eval "$(flox activate -d ~)" && unset LD_AUDIT

### Luarocks
# eval "$(luarocks path --bin)"


# Prompt
# --------------------------------------------------------------------

### Get the necessary tput codes
blue=$(tput setaf 12)
red=$(tput setaf 9)
gray=$(tput setaf 8)
reset=$(tput sgr0)

### Export minimalist prompt
export PS1="\[${blue}\]\w\[${red}\]\$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[${gray}\] →\[${reset}\] "

### Enable improved wezterm experience
eval "$(wezterm shell-completion --shell bash)" && source ~/.config/wezterm/wezterm.sh

### Nice colorized output
export LS_COLORS="$(vivid generate catppuccin-mocha)"


# Zoxide
# --------------------------------------------------------------------

eval "$(zoxide init bash)"


# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------

fzf-down() {
  fzf --height 50% "$@" --border
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") | sed '/^$/d' |
    fzf-down --no-hscroll --reverse --ansi +m -d "\t" -n 2 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-nvim} "$file"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# atuin
# --------------------------------------------------------------------

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

if [[ -f ~/.atuin/bin/env ]]; then
  source $HOME/.atuin/bin/env
  eval "$(atuin init bash)"
  bind -x '"\C-r": __atuin_history'
fi
