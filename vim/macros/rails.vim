" macros/rails.vim
" Author: Rainer Borene

" Migrations {{{

function! s:migrationList(ArgLead, CmdLine, CursorPos)
  let migrations = rails#app().relglob("db/migrate/",a:ArgLead."[0-9_]*",".rb")
  return map(migrations,'s:sub(v:val,"^[0-9]*_","")')
endfunction

" }}}

Rnavcommand admin app/admin -suffix=.rb -default=dashboard
Rnavcommand job app/jobs -suffix=.rb
