# ctrl-h/j/k/l move between Herdr app panes (smart-splits style, the shell half).
# When there's no pane that way, the key does what it normally does.
# nvim handles the same keys itself (lua/rainer/herdr_splits.lua).
status is-interactive; or exit
set -q HC_TERMINAL_ID; or exit # only inside herdr-core terminals

set -g __herdr_app "/mnt/c/Users/Rainer Borene/AppData/Local/Programs/herdr-app/herdr-app.exe"
test -x "$__herdr_app"; or exit

function __herdr_focused_pane
    $__herdr_app status 2>/dev/null | string match -rg '"focused_pane":\s*"([^"]*)"'
end

function __herdr_nav -a direction fallback
    set -l before (__herdr_focused_pane)
    $__herdr_app do pane.go --direction $direction >/dev/null 2>&1
    if test "$before" = (__herdr_focused_pane)
        eval $fallback
    end
end

# fish sets up key bindings at the first prompt; bind after that.
function __herdr_nav_bind --on-event fish_prompt
    functions -e __herdr_nav_bind
    bind \ch '__herdr_nav left "commandline -f backward-delete-char"'
    bind \cj '__herdr_nav down "commandline -f execute"'
    bind \ck '__herdr_nav up "commandline -f kill-line"'
    bind \cl '__herdr_nav right "commandline -f clear-screen"'
end
