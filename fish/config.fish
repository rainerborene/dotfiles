# Useful aliases {{{

. ~/.dotfiles/fish/z.fish

alias vi 'vim'
alias v 'vim'

alias j 'z'
alias g 'git'
alias c 'clear'
alias l 'tree --dirsfirst -ChaFL 1'
alias ls 'ls -h'
alias hl 'less -R'
alias tailf 'tail -f'
alias cuts "cut -d' '"
alias pp 'python -mjson.tool'
alias serve_this 'python -m SimpleHTTPServer'
alias collapse "sed -e 's/  */ /g'"
alias reload '. ~/.config/fish/config.fish'

if test (uname) = 'Linux'
    alias o 'gvfs-open'
    alias oo 'gvfs-open (pwd)'
    alias pbc 'xclip -selection clipboard'
    alias pbp 'xclip -selection clipboard -o'
else
    alias o 'open'
    alias oo 'open .'
    alias pbc 'pbcopy'
    alias pbp 'pbpaste'
end

alias b 'bundle'
alias be 'bundle exec'
alias rs 'rails s thin'
alias rc 'rails console'
alias fore 'foreman start -f Procfile.dev'

function psg -d "Grep for a running process, returning its PID and full string"
    ps auxww | grep --color=always $argv | grep -v grep | collapse | cuts -f 2,11-
end

function psk -d "Kill all running processes with given name"
    psg $argv | awk '{print $1}' | xargs kill -9
end

function gopath -d "Enter \$GOPATH directory"
    cd $GOPATH/src/github.com/rainerborene
end

function ip -d "Send IP address to clipboard"
    curl -s icanhazip.com | pbc
end

function mcd
    mkdir -p $argv
    cd $argv
end

# }}}
# Completions {{{

function make_completion --argument alias command
    complete -f -c $alias -a "(
        set -l cmd (commandline -op);
        set -e cmd[1];
        complete -f -C\"$command \$cmd\";
    )"
end

make_completion g 'git'

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
set -gx GPG_TTY (tty)
set -gx EDITOR vim
set -gx GOPATH $HOME/.go

prepend_to_path "/bin"
prepend_to_path "/sbin"
prepend_to_path "/usr/sbin"
prepend_to_path "/usr/bin"
prepend_to_path "/usr/local/bin"
prepend_to_path "/usr/local/heroku/bin"
prepend_to_path "$HOME/.rbenv/bin"
prepend_to_path "$HOME/.rbenv/shims"
prepend_to_path "/usr/local/share/npm/bin"
prepend_to_path "$GOPATH/bin"
prepend_to_path "./bin"

# }}}
# Bind Keys {{{

function fish_user_key_bindings
    bind \ce accept-autosuggestion
end

# }}}
# Prompt {{{

function git_prompt
    if git rev-parse --git-dir >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color red
        printf '%s' (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set_color normal
    end
end

function fish_prompt
    set last_status $status

    z --add "$PWD"

    echo

    set_color red
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
        set_color black -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end

    set_color normal
end

# }}}
# Always work in a tmux session {{{

if type tmux >/dev/null 2>&1
    if test $TERM != "screen-256color" -a $TERM != "screen"
        tmux attach -t work; or tmux new -s work; exit
    end
end

# }}}

true
