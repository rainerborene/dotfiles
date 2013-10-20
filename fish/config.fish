# Useful aliases {{{

. ~/.dotfiles/fish/z.fish

alias v 'vim'
alias m 'mvim'

alias tm 'tmux -u2'
alias tms 'tm list-sessions'
alias tmt 'tm attach -t'
alias tat 'tm attach -t (basename $PWD)'

alias j 'z'
alias g 'git'
alias c 'clear'
alias l 'tree --dirsfirst -ChaFL 1'
alias hl 'less -R'
alias tailf 'tail -f'
alias cuts "cut -d' '"
alias pp 'python -mjson.tool'
alias serve_this 'python -m SimpleHTTPServer'
alias collapse "sed -e 's/  */ /g'"
alias mysql_repair 'mysqlcheck --auto-repair --check --optimize --all-databases -u root'
alias reload '. ~/.config/fish/config.fish'

alias o 'open'
alias oo 'open .'
alias pbc 'pbcopy'
alias pbp 'pbpaste'

# ruby on rails
alias b 'bundle'
alias be 'bundle exec'
alias rs 'rails s thin'
alias rc 'rails console'
alias fore 'foreman start -f Procfile.dev'
alias mina 'bundle exec mina'

function psg -d "Grep for a running process, returning its PID and full string"
    ps auxww | grep --color=always $argv | grep -v grep | collapse | cuts -f 2,11-
end

function psk -d "Kill all running processes with given name"
    psg $argv | awk '{print $1}' | xargs kill -9
end

function emptytrash -d "Empty the OS X trash folders"
    sudo rm -rfv /Volumes/*/.Trashes
    sudo rm -rfv ~/.Trash
    sudo rm -rfv /private/var/log/asl/*.asl
end

function utf8_encode
    set -l encoding (file -I $argv | cut -d '=' -f 2)
    iconv -f $encoding -t utf-8 $argv > $argv.utf8
    rm -v $argv; and mv -v $argv.utf8 $argv
end

function mcd
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
set -gx EDITOR vim
set -gx GOPATH $HOME/.go
set -gx PYTHONPATH /usr/local/lib/python2.7/site-packages $PYTHONPATH
set -gx PKG_CONFIG_PATH (brew --prefix sqlite)/lib/pkgconfig
set -gx RUBY_HEAP_MIN_SLOTS 1000000
set -gx RUBY_HEAP_SLOTS_INCREMENT 1000000
set -gx RUBY_HEAP_SLOTS_GROWTH_FACTOR 1
set -gx RUBY_GC_MALLOC_LIMIT 100000000
set -gx RUBY_HEAP_FREE_MIN 500000
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
prepend_to_path "$GOPATH/bin"
prepend_to_path "./bin"

# }}}
# Bind Keys {{{

function fish_user_key_bindings
    bind \cn accept-autosuggestion
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
    set last_status $status

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

    if test $last_status -eq 0
        set_color white -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end

    set_color normal
end

# }}}
# Always work in a tmux session {{{

if test -x (which tmux)
    if test $TERM != "screen-256color" -a $TERM != "screen"
        tmux attach -t hack; or tmux new -s hack; exit
    end
end

# }}}
# Loads different environment variables depending on your path {{{

eval (direnv hook fish)

# }}}

true
