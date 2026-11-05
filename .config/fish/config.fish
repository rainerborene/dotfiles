# Environment variables
# --------------------------------------------------------------------

source ~/.fish_profile 2>/dev/null

set -gx fish_greeting
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

fish_add_path "/usr/bin"
fish_add_path "/usr/local/bin"
fish_add_path "/usr/local/share/npm/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.fzf/bin"
fish_add_path "$HOME/.local/share/pnpm"
fish_add_path "$HOME/.grok/bin"


# Aliases
# --------------------------------------------------------------------

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias cdr 'cd (git rev-parse --show-toplevel)'
alias j 'z'
alias g 'git'
alias la 'ls -la'
alias ls 'eza --group-directories-first'
alias l 'eza -TalL1 --group-directories-first --no-time --no-user --no-permissions'
alias top 'btop'
alias htop 'btop'
alias vim 'nvim'
alias vi 'nvim'
alias v 'nvim'
alias open 'wsl-open'
alias rmzone 'find . -name "*:Zone.Identifier" -delete'
alias mr 'mise run'
alias be 'bundle exec'
alias rc 'rails console'
alias rs 'CONSOLE_LEVEL=debug rails server'
alias dkk 'docker kill (docker ps -q)'
alias cl 'claude --dangerously-skip-permissions'
alias cx 'codex --dangerously-bypass-approvals-and-sandbox'
alias gk 'grok --always-approve'

abbr p 'pnpm'

if command -sq win32yank.exe
  alias pbcopy 'win32yank.exe -i --crlf'
  alias pbpaste 'win32yank.exe -o --lf'
else
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'
end

function dkrm -d "Delete docker images by given name"
  docker images --format json \
    | jq -r --arg image "$argv" 'select((.Repository + ":" + .Tag) | contains($image)).ID' \
    | xargs docker rmi
end


# Mise
# --------------------------------------------------------------------

mise activate fish | source


# Zoxide
# --------------------------------------------------------------------

if status is-interactive
  zoxide init fish | source
end


# fzf (https://github.com/junegunn/fzf)
# --------------------------------------------------------------------

set -x FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
set -x FZF_ALT_C_OPTS "--preview 'tree -C {} | head -200'"
set -x FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --border"
set -x FZF_CTRL_T_COMMAND 'fd --type f --type d --hidden --follow --exclude .git'
set -x FZF_CTRL_T_OPTS "--preview 'bat -n --color=always {} --line-range :200'"
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
# Minimal look in graphite's colours, on the terminal's own background.
# fzf-lua inherits this variable and overrides what it needs (its own colours and window).
set -x FZF_DEFAULT_OPTS "\
  --layout=reverse --info=inline-right --prompt='› ' --pointer='▌' --marker='▌' \
  --gutter=' ' --no-separator --no-scrollbar \
  --color=fg:#d2d4d9,fg+:#eeeeef,bg+:#25272b,gutter:-1,query:#eeeeef \
  --color=hl:#96b2d7,hl+:#b0cbef,prompt:#96b2d7,pointer:#96b2d7,marker:#a6bd91 \
  --color=info:#696a6d,spinner:#696a6d,header:#696a6d,border:#393b3f"
# difftastic: "light" picks the normal red/green (graphite's softer #dc8c95 / #a6bd91)
# instead of the bright bold ones; nothing else changes on a dark background
set -x DFT_BACKGROUND light

function fco -d "Fuzzy-find and checkout a branch"
  git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)" | read -z branches;
  set branch (printf '%s' $branches | fzf -d (math 2 + (echo "$branches" | wc -l)) +m)
  test -n "$branch"; and git checkout (echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
end

function fe -d "Open the selected file with the default editor"
  set -l file (fzf --query="$argv[1]" --select-1 --exit-0 --height=40%)
  test -n "$file"; and nvim $file
end

if status is-interactive
  fzf --fish | source
end


# Vivid
# --------------------------------------------------------------------

if test -x (which vivid); and status is-interactive
  set -x LS_COLORS (vivid generate ansi)
end


# Atuin
# --------------------------------------------------------------------

if status is-interactive
  atuin init fish | source
end


# Homebrew
# --------------------------------------------------------------------

if test -d /opt/homebrew/bin
  eval "$(/opt/homebrew/bin/brew shellenv)"
end
