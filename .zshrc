# Essentials {{{

DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
UPDATE_ZSH_DAYS=13
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="lambda"

plugins=(git git-extras z history-substring-search)

autoload zmv

source $ZSH/oh-my-zsh.sh

eval $HOME/.dotfiles/bin/base16-twilight.dark.sh

# }}}
# Environment variables {{{

export EDITOR=nvim
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--extended --cycle --no-256 --bind "ctrl-z:toggle"'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)' --header 'Press CTRL-Y to copy command into clipboard' --border"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export GOPATH=$HOME/go
export LESS='-R --silent'
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export PATH=$HOME/.cargo/bin:$HOME/.dotfiles/bin:$HOME/.rbenv/bin:$PATH
export PATH=./bin/:./node_modules/.bin/:$GOPATH/bin:$PATH

# }}}
# Options {{{

setopt no_beep
setopt hist_ignore_dups
setopt histignorealldups

# }}}
# Key mappings {{{

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

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

alias be='bundle exec'
alias rc='rails console'
alias rs='rails server'
alias fore='foreman start -f Procfile.dev'

# }}}
# FZF {{{

# Z integration
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 50% --border +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

# fd - cd to selected directory
fd() {
  DIR=`find ${1:-.} -type d -not -iwholename "*.git*" 2> /dev/null | fzf --height 50% --border` && cd "$DIR"
}

# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf --height 50% --border -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -200 '" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'nvim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-$COLUMNS | fzf --nth=2 --tiebreak=begin
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf --height 50% --border --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# }}}
# Rbenv {{{

if [[ -x $(which rbenv 2>/dev/null) ]]; then
  eval "$(rbenv init -)"
fi

# }}}
