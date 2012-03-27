" plugin/railsmore.vim
" Author: Rainer Borene
"
" Extension for vim-rails plugin from Tim Pope.

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

function! s:RailsMore()
  command! -nargs=? -complete=customlist,s:migrationList -bar Rredo call s:migrationRedo('<args>')
  Rnavcommand admin app/admin -suffix=.rb -default=dashboards
endfunction

" }}}

autocmd User BufEnterRails call s:RailsMore()
