# Useful aliases {{{

. ~/.dotfiles/lib/z.fish

alias j 'z'
alias l 'tree --dirsfirst -ChFL 1'
alias hl 'less -R'
alias c 'clear'
alias e 'vim -c CtrlP'
alias v 'vim'
alias V 'vim .'
alias m 'mvim .'
alias tm 'tmux -u2'
alias tat 'tmux attach -t (basename $PWD)'
alias pp 'python -mjson.tool'
alias serve_this 'python -m SimpleHTTPServer'
alias reload '. ~/.config/fish/config.fish'
alias tailf 'tail -f'
alias collapse "sed -e 's/  */ /g'"
alias cuts "cut -d' '"
alias mysql_repair 'mysqlcheck --auto-repair --check --optimize --all-databases -u root'

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
alias gcd 'cd (git rev-parse --show-toplevel)'
alias gitv 'vim .git/index -c "Gitv --all" -c "tabonly"'

alias o 'open'
alias oo 'open .'
alias pbc 'pbcopy'
alias pbp 'pbpaste'
alias vim '/Applications/MacVim.app/Contents/MacOS/Vim'

# ruby on rails
alias b 'bundle'
alias be 'bundle exec'
alias rs 'rails s thin'
alias rc 'rails console'
alias fore 'foreman start -f Procfile.dev'

function psg -d "Grep for a running process, returning its PID and full string"
    ps auxww | grep --color=always $argv | grep -v grep | collapse | cuts -f 2,11-
end

function gg -d "Commit pending changes and quote all args as message"
    git commit -v -a -m "$argv"
end

function utf8_encode
    set -l encoding (file -I $argv | cut -d '=' -f 2)
    iconv -f $encoding -t utf-8 $argv > $argv.utf8
    rm -v $argv; and mv -v $argv.utf8 $argv
end

function md
    mkdir -p $argv
    cd $argv
end

# }}}
# Directories {{{

alias ..    'cd ..'
alias ...   'cd ../..'
alias ....  'cd ../../..'
alias ..... 'cd ../../../..'

# }}}
# Environment variables {{{

function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

set -gx fish_greeting ''
set -gx RUBY_GC_MALLOC_LIMIT 60000000
set -gx RUBY_FREE_MIN 200000
set -gx PYTHONPATH /usr/local/lib/python2.7/site-packages $PYTHONPATH
set -gx EDITOR vim

set -gx PATH "/usr/X11R6/bin"
prepend_to_path "/usr/bin"
prepend_to_path "/bin"
prepend_to_path "/usr/sbin"
prepend_to_path "/sbin"
prepend_to_path "/usr/local/bin"
prepend_to_path "$HOME/.rbenv/bin"
prepend_to_path "$HOME/.rbenv/shims"
prepend_to_path "/usr/local/mysql/bin"
prepend_to_path "/usr/local/share/npm/bin"

# }}}
# Bind Keys {{{

function fish_user_key_bindings
    bind \cn accept-autosuggestion

    # Ignore iterm2 escape sequences.  Vim will handle them if needed.
    bind \e\[I true
    bind \e\[O true
    # ]]
end

# }}}
# Prompt {{{

function git_prompt
    if git rev-parse --git-dir >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set_color normal
    end
end

function fish_prompt
    z --add "$PWD"

    if test -f .ruby-version
        set RBENV_VERSION (rbenv local)
    else
        set RBENV_VERSION (rbenv global)
    end

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
    printf '➜ '

    set_color normal
end

# }}}

if status --is-interactive
    command fortune -s | cowsay -f tux -g
end
