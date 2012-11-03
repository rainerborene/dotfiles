" https://github.com/akitaonrails/vimfiles/blob/master/vimrc#L313
source ~/.vim/snippets/support_functions.vim

function! s:SetupSnippets()
  " if we're in a rails env then read in the rails snippets
  if filereadable("./config/environment.rb")
    call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
    call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
  endif

  call ExtractSnips("~/.vim/snippets/html", "eruby")
  call ExtractSnips("~/.vim/snippets/html", "xhtml")
  call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

autocmd VimEnter * call s:SetupSnippets()
