function! OpenURL(url)
  if has("win32")
    exe printf('!start cmd /cstart /b "%s"', a:url)
  elseif has("mac")
    exe printf('silent !open "%s"', a:url)
  elseif $DISPLAY !~ '^\w'
    exe printf('silent !sensible-browser "%s" > /dev/null 2>&1', a:url)
  else
    exe printf('silent !sensible-browser -T "%s" > /dev/null 2>&1', a:url)
  endif
  redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)
" open URL under cursor in browser
nnoremap gb :OpenURL <cfile><CR>
nnoremap gC :OpenURL <C-R>%<CR>
vnoremap gA "*y:OpenURL http://www.answers.com/<C-R>y<CR>
vnoremap gG "*y:OpenURL http://www.google.com/search?q=<C-R>y<CR>
vnoremap gW "*y:OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<C-R>y<CR>
