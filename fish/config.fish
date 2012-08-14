# Useful aliases {{{

. ~/.dotfiles/lib/z.fish

alias j 'z'
alias l 'tree --dirsfirst -ChFL 1'
alias c 'clear'
alias e 'vim -c CtrlP'
alias v 'vim'
alias V 'vim .'
alias m 'mvim .'
alias tm 'tmux -u2'
alias md 'mkdir -p'
alias hi 'history | tail -20'
alias pp 'python -mjson.tool'
alias serve_this 'python -m SimpleHTTPServer'

alias g 'git'
alias gd 'git diff'
alias gdc 'git diff --cached'
alias ga 'git add'
alias gbd 'git branch -D'
alias gs 'git status'
alias gca 'git commit -a -m'
alias gm 'git merge --no-ff'
alias gpt 'git push --tags'
alias gp 'git push'
alias grh 'git reset --hard'
alias gb 'git branch'
alias gcob 'git checkout -b'
alias gco 'git checkout'
alias gba 'git branch -a'
alias gcp 'git cherry-pick'
alias gl 'git log --pretty="format:%Cgreen%h%Creset %an - %s" --graph'
alias gpom 'git pull --rebase origin master'
alias gcd 'cd "`git rev-parse --show-toplevel`"'
alias gitv 'vim .git/index -c "Gitv --all" -c "tabonly"'

alias o 'open'
alias oo 'open .'
alias pbc 'pbcopy'
alias pbp 'pbpaste'
alias vim '/Applications/MacVim.app/Contents/MacOS/Vim'

# commit pending changes and quote all args as message
function gg
  git commit -v -a -m "$argv"
end

# ruby on rails
alias b 'bundle'
alias be 'bundle exec'
alias rs 'rails s thin'
alias rc 'rails console'

# utilities
function utf8_encode
  set -l encoding (file -I $argv | cut -d '=' -f 2)
  iconv -f $encoding -t utf-8 $argv > $argv.utf8
  rm -v $argv; and mv -v $argv.utf8 $argv
end


# }}}
# Directories {{{

alias ..    'cd ..'
alias ...   'cd ../..'
alias ....  'cd ../../..'
alias ..... 'cd ../../../..'

# }}}
# Environment variables {{{

set -g -x EDITOR vim
set -g -x fish_greeting ''

set PORT '5000'
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
set PATH /usr/local/mysql/bin $PATH

# }}}
# Prompt {{{

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set gray (set_color -o black)

function git_prompt
    if git root >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git currentbranch ^/dev/null)
        set_color green
        git_prompt_status
        set_color normal
    end
end

function fish_prompt
    z --add "$PWD"

    echo

    set_color magenta
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname|cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    git_prompt

    echo
    set_color white -o
    printf '><((°> '

    set_color normal
end

# }}}
