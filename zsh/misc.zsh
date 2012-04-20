# dir navigation
alias cdd='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# general
alias j='z'
alias e='vim -c CtrlP'
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
alias l='tree -htCL 1 --dirsfirst'
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias reload='source ~/.zshrc'

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

# output man pages as plain text with col
pman() {
  man $1 | col -b | expand
}

# substitute file names
mvall() {
  if [[ (-n $1 && -n $2) ]]; then
    for filename in $(find * -name "*$1*"); do
      mv -v $filename $(echo $filename | sed "s/$1/$2/")
    done
  else
    echo "Error: missing arguments."
  fi
}

# encodes to utf-8
utf8_encode() {
  local encoding=$(file -I $1 | cut -d '=' -f 2)
  iconv -f $encoding -t utf-8 $1 > $1.utf8
  rm -v $1 && mv -v $1.utf8 $1
}

login_message() {
  local sentences="~/.sentences.txt"
  if [ -e $sentences ]; then
    cat $sentences | sort --random-sort | head -n 1
  else
    fortune
  fi
}
