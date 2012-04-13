# git
alias gs='git status'
alias gd='git diff --color'
alias gdc='git diff --cached --color'
alias gl='git log --oneline --color --max-count=15 --decorate'
alias gu='git pull'
alias gt='git tag'
alias gsm='git submodule'
alias gitv='vim .git/index -c "Gitv --all" -c "tabonly"'

# commit pending changes and quote all args as message
gg() {
  git commit -v -a -m "$*"
}
