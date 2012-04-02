" macros/rails.vim
" Author: Rainer Borene

" Migrations {{{

function! s:migrationList(ArgLead, CmdLine, CursorPos)
  let migrations = rails#app().relglob("db/migrate/",a:ArgLead."[0-9_]*",".rb")
  return map(migrations,'s:sub(v:val,"^[0-9]*_","")')
endfunction

function! s:migrationRedo(name)
  let l:buffer_name = a:name ? a:name : expand("%:d")
  let l:migration = matchstr(l:buffer_name, '\c\v\d+')
  if l:migration
    exec printf("Rake db:migrate:redo VERSION=%s db:test:clone", l:migration)
  else
    echohl ErrorMsg
    echomsg "Open a migration in the current buffer to redo."
    echohl None
  end
endfunction

" }}}

command! -nargs=? -complete=customlist,s:migrationList -bar Rredo call s:migrationRedo('<args>')
Rnavcommand admin app/admin -suffix=.rb -default=dashboards
