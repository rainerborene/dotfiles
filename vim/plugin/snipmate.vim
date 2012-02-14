" https://github.com/akitaonrails/vimfiles/blob/master/vimrc#L313
try
  source ~/.vim/snippets/support_functions.vim
catch
  source ~/vimfiles/snippets/support_functions.vim
endtry

function! s:SetupSnippets()
  "if we're in a rails env then read in the rails snippets
  if filereadable("./config/environment.rb")
    try
      call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
      call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
    catch
      call ExtractSnips("~/vimfiles/snippets/ruby-rails", "ruby")
      call ExtractSnips("~/vimfiles/snippets/eruby-rails", "eruby")
    endtry
  endif

  try
    call ExtractSnips("~/.vim/snippets/html", "eruby")
    call ExtractSnips("~/.vim/snippets/html", "xhtml")
    call ExtractSnips("~/.vim/snippets/html", "php")
  catch
    call ExtractSnips("~/vimfiles/snippets/html", "eruby")
    call ExtractSnips("~/vimfiles/snippets/html", "xhtml")
    call ExtractSnips("~/vimfiles/snippets/html", "php")
  endtry
endfunction

autocmd vimenter * call s:SetupSnippets()
