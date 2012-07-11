# git
alias gd="git diff | mate"
alias ga="git add"
alias gbd="git branch -D"
alias gs="git status -s"
alias gst="git status"
alias gca="git commit -a -m"
alias gm="git merge --no-ff"
alias gpt="git push --tags"
alias gp="git push"
alias grh="git reset --hard"
alias gb="git branch"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gba="git branch -a"
alias gcp="git cherry-pick"
alias gl="git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph"
alias gpom="git pull origin master"
alias gcd='cd "`git rev-parse --show-toplevel`"'
alias gitv='vim .git/index -c "Gitv --all" -c "tabonly"'

# commit pending changes and quote all args as message
gg() {
  git commit -v -a -m "$*"
}
