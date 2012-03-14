# dir navigation
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
alias tmux='tmux -u2'
alias tailf='tail -f'
alias lsd='ls -l | grep "^d"'
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias serve_this='python -m SimpleHTTPServer'
alias l='tree -hCL 1'
alias reload='source ~/.zshrc'

# git
alias gs='git status'
alias gd='git diff --color'
alias gdc='git diff --cached --color'
alias gl='git log --oneline --color --max-count=15 --decorate'
alias gu='git pull'
alias gt='git tag'
alias gsm='git submodule'

# commit pending changes and quote all args as message
gg() {
  git commit -v -a -m "$*"
}

# ruby on rails
alias b='bundle'
alias rs='rails s thin'
alias rdbs='rake db:migrate:status'
alias rst='touch tmp/restart.txt'

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

mvall() {
  if [[ (-n $1 && -n $2) ]]; then
    for filename in $(find * -name "*$1*"); do
      mv -v $filename $(echo $filename | sed "s/$1/$2/")
    done
  else
    echo "Error: missing arguments."
  fi
}
