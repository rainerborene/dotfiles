" http://stackoverflow.com/questions/1830839/how-to-open-multiple-files-in-vim-after-vimgrep
" http://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim/5686810#5686810
command! -nargs=+ Qfixdo call QuickFixDo(<q-args>)
function! QuickFixDo(cmd)
  let bufnam = {}
  for q in getqflist()
    let bufnam[q.bufnr] = bufname(q.bufnr)
  endfor  
  for n in keys(bufnam)
    exe 'buffer' n
    exe a:cmd
    update
  endfor
endfunction
