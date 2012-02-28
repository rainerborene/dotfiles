# vim:set ft=sh:

# dir navigation
alias cdd='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# general
alias j='z'
alias e='vim .'
alias m='mvim .'
alias c='clear'
alias fn='find . -name'
alias hi='history | tail -20'
alias pp='python -mjson.tool'
alias tailf='tail -f'
alias lsd='ls -l | grep "^d"'
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias serve_this='python -m SimpleHTTPServer'
alias l='tree -hCL 1'

# git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gs='git status'
alias gss='git status -sb'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gd='git diff --color'
alias gdc='git diff --cached --color'
alias gl='git log --oneline --color --max-count=15 --decorate'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gu='git pull'
alias gt='git tag'
alias gsm='git submodule'

# commit pending changes and quote all args as message
gg() {
  git commit -v -a -m "$*"
}

# ruby on rails
alias rs='rails s thin'
alias rc='rails c'
alias rtu='rake test:units'
alias rtf='rake test:functionals'
alias rti='rake test:integration'
alias rdbm='rake db:migrate'
alias rdbs='rake db:migrate:status'
alias b='bundle'
alias be='bundle exec'
alias rst='touch tmp/restart.txt'

# run rake without worring about
# bundler wrapper.
rake() {
  if [ -e Gemfile ]; then
    bundle exec rake $@
  else
    `which rake` $@
  fi
}

# rubygems
alias gems='gem search -b'
alias geml='gem list -l'
alias gemi='gem install'
alias gemu='gem uninstall'

# linux specific aliases
if [[ "$UNAME" == "Linux" ]]; then
  alias ls='ls --color -h'
  alias lc='ls --color -1'
  alias ll='ls --color -laGh'
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  alias open='gnome-open > /dev/null 2>&1'
fi

# mac osx compatible aliases
if [[ "$UNAME" == "Darwin" ]]; then
  alias ls='ls -h'
  alias lc='ls -1'
  alias ll='ls -lhoGa'
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
fi

# source dotfiles
alias reload='source ~/.zshrc'
