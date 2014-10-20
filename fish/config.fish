# Start X at login {{{

if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

# }}}
# Useful aliases {{{

. ~/.dotfiles/fish/z.fish

alias m 'mvim'
alias v 'vim'

alias tm 'tmux -u2'
alias tms 'tm list-sessions'
alias tmt 'tm attach -t'
alias tat 'tm attach -t (basename $PWD)'

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
alias mysql_repair 'mysqlcheck --auto-repair --check --optimize --all-databases -u root'
alias reload '. ~/.config/fish/config.fish'

alias o 'open'
alias oo 'open .'
alias pbc 'pbcopy'
alias pbp 'pbpaste'

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
    cd $GOPATH/src
end

function emptytrash -d "Empty the OS X trash folders"
    sudo rm -rfv /Volumes/*/.Trashes
    sudo rm -rfv ~/.Trash
    sudo rm -rfv /private/var/log/asl/*.asl
end

function ip -d "Send IP address to clipboard"
    set -l ip (curl -s icanhazip.com)
    echo $ip | pbcopy
    echo $ip
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
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx SSL_CERT_FILE /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
set -gx PYTHONPATH /usr/local/lib/python2.7/site-packages $PYTHONPATH
set -gx JAVA_HOME (/usr/libexec/java_home)
set -gx AWS_AUTO_SCALING_HOME /usr/local/autoscaling
set -gx AWS_AUTO_SCALING_URL https://autoscaling.sa-east-1.amazonaws.com
set -gx PKG_CONFIG_PATH (brew --prefix sqlite)/lib/pkgconfig
set -gx PKG_CONFIG_PATH /usr/local/Cellar/libxml2/2.9.1/lib/pkgconfig $PKG_CONFIG_PATH
set -gx PATH "/usr/X11R6/bin"

prepend_to_path "/Applications/Apache Flex SDK/bin"
prepend_to_path "/usr/bin"
prepend_to_path "/bin"
prepend_to_path "/usr/sbin"
prepend_to_path "/sbin"
prepend_to_path "/usr/local/bin"
prepend_to_path (rbenv root)/bin
prepend_to_path (rbenv root)/shims
prepend_to_path "/usr/local/share/npm/bin"
prepend_to_path "$AWS_AUTO_SCALING_HOME/bin"
prepend_to_path "$GOPATH/bin"
prepend_to_path "$HOME/.dotfiles/mutt"
prepend_to_path "./bin"

eval (luarocks path | tr '=' ' ' | sed 's/export/set -gx/')

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

if which -s tmux
    if test $TERM != "screen-256color" -a $TERM != "screen"
        tmux attach -t hack; or tmux new -s hack; exit
    end
end

# }}}

true
