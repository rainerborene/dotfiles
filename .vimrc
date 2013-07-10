" .vimrc
filetype off
set nocompatible
set rtp+=~/.vim/bundle/pathogen
call pathogen#infect()

runtime plugin/sensible.vim
runtime plugin/scriptease.vim
runtime snippets/support_functions.vim

set hidden
set nobackup
set noswapfile
set splitbelow
set splitright
set spelllang=pt,en
set spellfile=~/.vim/spell/custom-dictionary.utf-8.add
set dictionary=/usr/share/dict/words
set wildmode=list:longest,full
set completeopt=longest,menuone,preview
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮
set fillchars=diff:⣿,vert:│
set showbreak=↪
set linebreak
set ignorecase
set smartcase
set hlsearch
set gdefault
set virtualedit+=block
set shortmess=atI
set textwidth=80
set formatoptions=qn1
set colorcolumn=+1
set lazyredraw
set synmaxcol=500
set foldopen-=block
set shiftwidth=2
set softtabstop=2
set expandtab
set wrap

" Color scheme {{{1

set background=dark
let g:badwolf_tabline = 2
let g:badwolf_html_link_underline = 0
let g:badwolf_css_props_highlight = 1
colorscheme badwolf

" }}}1
" Statusline {{{1

set statusline=%f%m\ %{fugitive#statusline()}%=
set statusline+=(%{&ff}/%{strlen(&fenc)?&fenc:&enc}/%{strlen(&ft)?&ft:'none'})
set statusline+=\ (line\ %l/%L,\ col\ %03c)

" }}}1
" Persistent undo {{{1

set undofile
set undoreload=10000
set undodir=~/.vim/tmp/undo

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

" }}}1
" Environments (GUI/Console) {{{1

if has('gui_running')
  set guifont=Menlo:h12

  " Remove all the UI cruft
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R

  highlight SpellBad term=underline gui=undercurl guisp=Orange
else
  set mouse=a
endif

" }}}1
" Mappings {{{1

let mapleader = ","
let maplocalleader = "\\"

" Abbreviations
ab #e # encoding: utf-8

" Easier bracket matching
map <Tab> %
map <C-o> <nop>

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Clean trailing whitespace
nnoremap <silent> <leader>w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

" Don't move on *
nnoremap * *<c-o>

" Switch segments of text with predefined replacements
nnoremap <silent> - :Switch<cr>

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s/ s/\v

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" I hate when the rendering occasionally gets messed up.
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Sort lines
nnoremap <leader>o vip:!sort<cr>
vnoremap <leader>o :!sort<cr>

" Speed up buffer switching
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" Easy filetype switching
nnoremap _rb :setf ruby<CR>
nnoremap _js :setf javascript<CR>

" Sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Clam
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Unbind scriptease mappings.
silent! aug! scriptease_help

" Kill window
nnoremap K :q<cr>

" Man
nnoremap M K

" Because esc is too far.
inoremap jj <Esc>

" Make Y consistent with C and D
call yankstack#setup()
nnoremap Y y$

" Yankstack
nmap H <Plug>yankstack_substitute_older_paste
nmap L <Plug>yankstack_substitute_newer_paste

" Select just-pasted text
nnoremap gV `[v`]

" Tabular alignment
vnoremap <Enter> :Tabularize /\v/<left>

" Move to last change
nnoremap gI `.

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Focus the current fold by folding all the others
nnoremap <leader>z zMzvzz

" Duplication
nnoremap <leader>d mz"dyy"dp`z
vnoremap <leader>d "dymz"dP`z``

" Insert Mode Completion
inoremap <C-o> <C-x><C-o>
inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>
inoremap <C-l> <C-x><C-l>

" The black hole register
noremap x "_x
noremap X "_X

" Clear search highlight
nnoremap <silent> <leader>/ :silent :nohlsearch<CR>

" Undo tree usable by humans
nnoremap <silent> <leader>u :GundoToggle<CR>

" Open CtrlP on different modes
nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" Copying text to the system clipboard.
"
" For some reason Vim no longer wants to talk to the OS X pasteboard through "*.
" Computers are bullshit.
function! g:FuckingCopyTheTextPlease() " {{{2
    let old_z = @z
    normal! gv"zy
    call system('pbcopy', @z)
    let @z = old_z
endfunction " }}}2
nnoremap <silent> <leader>p mz:r!pbpaste<cr>`z
vnoremap <silent> <leader>y :<c-u>call g:FuckingCopyTheTextPlease()<cr>

" Start a process in a new, focused split pane. {{{2
function! SplitWindow()
  call system(printf("tmux splitw -p 25 -c '%s' '%s'", getcwd(), exists('b:start') ? b:start : ''))
endfunction
" }}}2

" Dispatch
nnoremap <silent> <leader>r :Rake<CR>
nnoremap <silent> <leader>t :Dispatch<CR>
nnoremap <silent> <leader>c :call SplitWindow()<CR>

" Ack searching
nnoremap <leader>a :Ack!<space>

" Quick editing
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>es :vsplit ~/.vim/snippets/<CR>
nnoremap <silent> <leader>ed :vsplit ~/.vim/spell/custom-dictionary.utf-8.add<cr>
nnoremap <silent> <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nnoremap <silent> <leader>et :vsplit ~/.tmux.conf<CR>
nnoremap <silent> <leader>eo :botright 10split ~/Google\ Drive/notes.txt<CR>
nnoremap <silent> <leader>ew :Explore<CR>

" Fugitive
nnoremap <silent> <leader>gl :silent Glog \| copen \| redraw!<cr>
nnoremap <silent> <leader>gd :Gvdiff -<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>

" }}}1
" Autocommands {{{1

augroup custom
  au!
  au BufRead *psql* setfiletype sql
  au FileType html,xml,js,css,php autocmd BufWritePre <buffer> normal ,w
  au FileType javascript,java,css setlocal foldmethod=marker foldmarker={,}
augroup END

augroup ft_fish
  au!
  au BufNewFile,BufRead *.fish setlocal filetype=fish
  au FileType fish setlocal foldmethod=marker foldmarker={{{,}}}
  au FileType fish setlocal commentstring=#\ %s
  au FileType fish let b:vimpipe_command="fish <(cat)"
augroup END

augroup ft_git
  au!
  au FileType git,gitcommit setlocal foldmethod=syntax colorcolumn& nolist
  au FileType gitcommit nmap <silent> <buffer> U :Git checkout -- <C-r><C-g><CR>
  au FileType gitcommit setlocal spell | wincmd K
  au BufReadPost fugitive://* set bufhidden=delete
  au User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
augroup END

augroup ft_markdown
  au!
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown
  au FileType markdown nnoremap <buffer> <localleader>1 yypVr=
  au FileType markdown nnoremap <buffer> <localleader>2 yypVr-
  au FileType markdown nnoremap <buffer> <localleader>3 I### <ESC>
  au FileType markdown setlocal wrap linebreak nolist
  au FileType markdown let b:vimpipe_command="multimarkdown"
  au FileType markdown let b:vimpipe_filetype="html"
augroup END

augroup ft_css
  au!
  au FileType css,scss,sass setlocal iskeyword+=- |
    \ call SuperTabChain(&omnifunc, "<c-n>") |
    \ call SuperTabSetDefaultCompletionType("<c-x><c-u>")
augroup END

augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au FileType qf,netrw setlocal colorcolumn& nocursorline nolist nowrap tw=0
  au FileType qf setlocal nolist nowrap | wincmd J | nnoremap <buffer> q :q<cr>
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

augroup ft_ruby
  au!
  au FileType ruby let b:vimpipe_command='ruby <(cat)'
  au User Rails
    \ if filereadable('zeus.json') |
    \   compiler rspec |
    \   let b:dispatch = 'zeus rake spec' |
    \   let b:start = 'zeus console' |
    \ end
augroup END

" Save when losing focus
au FocusLost * :silent! wall

" Restore cursor position
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
augroup fast_completion
  au!
  au InsertEnter *
    \ if !exists('w:last_fdm') |
    \   let w:last_fdm=&foldmethod |
    \   setlocal foldmethod=manual |
    \ endif

  au InsertLeave,WinLeave *
    \ if exists('w:last_fdm') |
    \   let &l:foldmethod=w:last_fdm |
    \   unlet w:last_fdm |
    \ endif
augroup END

" }}}1
" Visual Mode */# from Scrooloose {{{1

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" }}}1
" Folding {{{1

function! MyFoldText()
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" }}}1
" Plugin configuration {{{1

" ack.vim {{{2
let g:ackprg = 'ag --smart-case --nogroup --nocolor --column'
" }}}2
" ruby.vim {{{2
let g:ruby_fold = 1
" }}}2
" netrw.vim {{{2
let g:netrw_banner = 0
let g:netrw_dirhistmax = 0
let g:netrw_use_errorwindow = 0
let g:netrw_list_hide = '\~$,^tags$'
let g:netrw_fastbrowse = 0
" }}}2
" supertab.vim {{{2
let g:SuperTabLongestHighlight = 1
let g:SuperTabDefaultCompletionType = '<c-n>'
" }}}2
" ctrlp.vim {{{2
let g:ctrlp_map = '<leader>,'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_filter_greps = 'egrep -iv "\.(png|jpe?g|bmp|gif|png)"'
let g:ctrlp_user_command = ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | ' . ctrlp_filter_greps]
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(jpg|jpe?g|bmp|gif|png)$',
  \ 'dir': '\v[\/](tmp|tags)$'
  \ }
" }}}2
" html5.vim {{{2
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
" }}}2
" sparkup.vim {{{2
let g:sparkupNextMapping = '<c-y>'
" }}}2
" gundo.vim {{{2
let g:gundo_help = 0
let g:gundo_preview_bottom = 1
" }}}2
" syntastic.vim {{{2
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_quiet_warnings = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'passive_filetypes': ['html', 'yaml']
  \ }
" }}}2
" rails.vim {{{2
let g:rails_projections = {
  \ "app/validators/*_validator.rb": { "command": "validator" },
  \ "app/presenters/*_presenter.rb": { "command": "presenter" },
  \ "app/admin/*.rb": {
  \   "command": "admin" ,
  \   "affinity": "model",
  \   "template": "ActiveAdmin.register %S do\nend"
  \ },
  \ "app/workers/*_worker.rb": {
  \   "command": "worker" ,
  \   "template": "class %SWorker\nend"
  \ },
  \ "spec/factories.rb": {
  \   "command": "factory",
  \   "template": "FactoryGirl.define do\nend"
  \ }}
" }}}2
" vitality.vim {{{2
let g:vitality_fix_cursor = 0
" }}}2

" }}}
