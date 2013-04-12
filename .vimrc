" Essentials --------------------------------------------------------------- {{{

filetype off
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on

" }}}
" Basic options ------------------------------------------------------------ {{{

set nocompatible
set history=1000
set autoread
set autowrite
set hidden
set spelllang=pt,en
set encoding=utf-8
set nobomb
set nobackup
set noswapfile
set shiftround
set updatecount=20
set ttimeout
set nottimeout
set ttyfast
set splitbelow
set splitright
set shell=/bin/bash
set lazyredraw
set matchtime=3
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/spell/custom-dictionary.utf-8.add

" }}}
" Appearance --------------------------------------------------------------- {{{

syntax on
set t_Co=256
set title
set cursorline
set backspace=indent,eol,start
set showcmd
set noshowmode
set wildmenu
set wildmode=list:longest,full
set wildignore+=*~,.git,*.pyc,*.o,*.spl,*.rdb
set wildignore+=*.DS_Store
set wildignore+=.sass-cache
set ruler
set nonumber
set norelativenumber
set numberwidth=5
set pumheight=10
set showbreak=↪
set virtualedit+=block
set shortmess=atI
set mousemodel=popup
set complete=.,w,b,u,U
set completeopt=longest,menuone,preview
set mouse=a
set ttymouse=xterm2
set background=dark
set colorcolumn=+1
set synmaxcol=500

let g:badwolf_tabline = 2
let g:badwolf_html_link_underline = 0
let g:badwolf_css_props_highlight = 1
colorscheme badwolf

if has("gui_running")
  " Remove all the UI cruft
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R

  highlight SpellBad term=underline gui=undercurl guisp=Orange

  if has("mac")
    set guifont=Menlo:h12
    set fuoptions=maxvert,maxhorz
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 9
    set lines=999 columns=999
  endif
end

" }}}
" Persistent undo ---------------------------------------------------------- {{{

set undofile
set undoreload=10000
set undodir=~/.vim/tmp/undo

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

" }}}
" Visual Cues -------------------------------------------------------------- {{{

set visualbell t_vb=
set ignorecase
set smartcase
set foldlevelstart=0
set laststatus=2
set incsearch
set hlsearch
set nostartofline
set gdefault
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set fillchars=diff:⣿,vert:│
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set list

" }}}
" Text Formatting ---------------------------------------------------------- {{{

set autoindent
set expandtab
set shiftwidth=2
set textwidth=80
set formatoptions=qrn1
set nojoinspaces
set nrformats=
set linebreak
set wrap

" }}}
" Filetype-specific -------------------------------------------------------- {{{

au FileType html,xml,js,css,php autocmd BufWritePre <buffer> normal ,w
au FileType javascript,java,css setlocal foldmethod=marker foldmarker={,}
au FileType qf,netrw setlocal colorcolumn& nolist
au FileType c setlocal foldmethod=syntax

au BufNewFile,BufRead *.tumblr.html setfiletype tumblr
au BufNewFile,BufRead *.ejs setfiletype html
au BufNewFile,BufRead *.rss setfiletype xml
au BufNewFile,BufRead *psql* setfiletype sql

augroup ft_php
  au!
  au FileType php setlocal foldmethod=syntax
  au FileType php let b:vimpipe_command="php -f %"
augroup END

augroup ft_java
  au!
  au FileType java compiler ant | setlocal makeprg=ant\ -find\ build.xml
  au FileType java setlocal efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
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
  au FileType git setlocal foldmethod=syntax
  au FileType git,gitv,gitcommit setlocal colorcolumn& nolist
  au FileType gitcommit setlocal spell | wincmd K
  au BufReadPost fugitive://* set bufhidden=delete
  au User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif
augroup END

augroup ft_mongo
  au!
  au BufNewFile,BufReadPost *.mql setlocal filetype=mongoql
  au FileType mongoql let b:vimpipe_command="mongo"
  au FileType mongoql let b:vimpipe_filetype="json"
augroup END

augroup ft_ruby
  au!
  au BufNewFile,BufRead {Vagrantfile,Guardfile,Capfile,Thorfile,pryrc,config.ru} setfiletype ruby
  au FileType ruby let b:vimpipe_command='ruby <(cat)'
  au FileType ruby setlocal foldmethod=syntax
  au FileType ruby
    \ if filereadable('zeus.json') |
    \   compiler rspec | let &mp = 'zeus rspec %' |
    \ end
augroup END

augroup ft_json
  au!
  au FileType json let b:vimpipe_command="python -m json.tool"
augroup END

augroup ft_html
  au!
  au FileType html setlocal foldmethod=manual
  au FileType html let b:vimpipe_command="lynx -dump -stdin"
augroup END

augroup ft_css
  au!
  au FileType sass
    \ call SuperTabChain(&omnifunc, "<c-p>") |
    \ call SuperTabSetDefaultCompletionType("<c-x><c-u>")
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

augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au FileType qf setlocal nolist nocursorline nowrap | wincmd J
  au BufReadPost netrw setlocal buftype=nofile bufhidden=delete nobuflisted
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
  au BufWritePost .vimrc source $MYVIMRC
augroup END

" Only show cursorline in the current window and in normal mode.
augroup cline
  au!
  au WinLeave * set nocursorline
  au WinEnter * set cursorline
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" Only shown when not in insert mode so I don't go insane.
augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:⌴
  au InsertLeave * :set listchars+=trail:⌴
augroup END

" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * :wincmd =

" Make terminal Vim trigger autoread more often.
au WinEnter,BufWinEnter,CursorHold * checktime

" Restore cursor position
au BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" }}}
" Mappings ----------------------------------------------------------------- {{{

" Leader keys
let mapleader = ","
let maplocalleader = "\\"

" Easier bracket matching
map <Tab> %
map <C-o> <nop>

" Delete a buffer without closing the window
nmap <leader>q <Plug>Kwbd

" Wipe all buffers which are not active
nmap <leader>hq <Plug>CloseHiddenBuffers

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Clean trailing whitespace
nnoremap <silent> <leader>w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

" Use the old surround.vim key.  I can't deal with the new one.
vmap s S

" Don't move on *
nnoremap * *<c-o>

" Switch segments of text with predefined replacements
nnoremap - :Switch<cr>

" For some reason pastetoggle doesn't redraw the screen (thus the status bar
" doesn't change) while :set paste! does, so I use that instead.
nnoremap <silent> <F6> :set paste!<CR>

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Make Y consistent with C and D
nnoremap Y y$

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Select just-pasted text
nnoremap gV `[v`]

" Move to last change
nnoremap gI `.

" Enter command mode quickly
nnoremap ; :

" Cmdheight switching
nnoremap <leader>1 :set cmdheight=1<cr>
nnoremap <leader>2 :set cmdheight=2<cr>

" Fuck you too, manual key.
nnoremap K <nop>

" Kill window
nnoremap K :q<cr>

" I hate when the rendering occasionally gets messed up.
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" Speed up buffer switching
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Tiled Window Management
nmap <C-N> <Plug>DWMNew
nmap <C-C> <Plug>DWMClose
nmap <C-@> <Plug>DWMFocus
nmap <C-Space> <Plug>DWMFocus

" Easy filetype switching
nnoremap _fs :setf fish<CR>
nnoremap _ss :setf sass<CR>
nnoremap _ht :setf html<CR>
nnoremap _vi :setf vim<CR>
nnoremap _ob :setf objc<CR>
nnoremap _rb :setf ruby<CR>
nnoremap _tu :setf tumblr<CR>
nnoremap _js :setf javascript<CR>
nnoremap _sql :setf sql<CR>

" Sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
vnoremap <Up> gk
vnoremap <Down> gj

" Abbreveations
iabbrev enc # encoding: utf-8

" Source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Clam
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Jump to line and column
noremap ' `

" Regenerate ctags
nnoremap <leader><cr> :silent !/usr/local/bin/ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Because escape is too far away
inoremap jj <ESC>

" Toggle 'keep current line in the center of the screen' mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Shortcut for []
onoremap id i[
onoremap ad a[
vnoremap id i[
vnoremap ad a[

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

" The black hole register
noremap x "_x
noremap X "_X

" Clear search highlight
nnoremap <silent> <leader>/ :silent :nohlsearch<CR>

" Open CtrlP on different modes
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>l :CtrlPLine<CR>
nnoremap <silent> <leader>. :CtrlPTag<CR>

" Some toggle commands
nnoremap <silent> <leader>u :GundoToggle<CR>

" Yank to OS X pasteboard.
noremap <leader>y "*y

" Paste from OS X pasteboard without messing up indent.
nnoremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
nnoremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

" Send visual selection to sprunge.us
vnoremap <leader>G :w !curl -sF 'sprunge=<-' 'http://sprunge.us' \| tr -d '\n ' \| pbcopy && open `pbpaste`<cr>

" Dispatch
nnoremap <leader>r :Make<CR>
nnoremap <leader>t :Dispatch<space>

" Ack searching
nnoremap <leader>a :Ack!<space>

" Fugitive
nnoremap <leader>gd :Gvdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gh :Gbrowse<cr>
nnoremap <leader>gco :Gread<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<space>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gv :Gitv --all<cr>
nnoremap <leader>gV :Gitv! --all<cr>

" }}}
" Visual Mode */# from Scrooloose ------------------------------------------ {{{

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" }}}
" SnipMate ----------------------------------------------------------------- {{{

source ~/.vim/snippets/support_functions.vim
function! s:SetupSnippets()
  if filereadable("./config/environment.rb")
    call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
    call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
  endif
  call ExtractSnips("~/.vim/snippets/html", "eruby")
  call ExtractSnips("~/.vim/snippets/html", "xhtml")
  call ExtractSnips("~/.vim/snippets/html", "php")
endfunction
autocmd VimEnter * call s:SetupSnippets()

" }}}
" Tab title ---------------------------------------------------------------- {{{

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'
    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label = bufname(buflist[winnr - 1])
  return fnamemodify(label == '' ? "untitled" : label, ":t")
endfunction

set guitablabel=%t
set tabline=%!MyTabLine()

" }}}
" Folding ------------------------------------------------------------------ {{{

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

" }}}
" Quick editing ------------------------------------------------------------ {{{

cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>ed :vsplit ~/.vim/spell/custom-dictionary.utf-8.add<cr>
nnoremap <silent> <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nnoremap <silent> <leader>et :vsplit ~/.tmux.conf<CR>
nnoremap <silent> <leader>ew :Explore<CR>

" }}}
" Plugin settings ---------------------------------------------------------- {{{

let g:dwm_map_keys = 0
let g:seek_enable_jumps = 1
let g:ackprg = 'ag --smart-case --nogroup --nocolor --column'
let g:SuperTabLongestHighlight = 1
let g:SuperTabDefaultCompletionType = '<c-n>'
let g:SuperTabNoCompleteAfter = ['^', '\v\s{2,}']
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:netrw_banner = 0
let g:netrw_dirhistmax = 0
let g:netrw_use_errorwindow = 0
let g:netrw_list_hide = '^\.,\~$,^tags$'
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_OpenHorizontal = 1
let g:Gitv_DoNotMapCtrlKey = 1
let g:sparkupNextMapping = '<c-o>'
let g:Powerline_stl_path_style = 'filename'
let g:Powerline_symbols = 'fancy'
let g:gundo_help = 0
let g:gundo_preview_bottom = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_quiet_warnings = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['html', 'yaml'] }
let g:surround_indent = 1
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_extensions = ['tag']
let g:ctrlp_filter_greps = 'egrep -iv "\.(png|jpe?g|bmp|gif|png)"'
let g:ctrlp_user_command = ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard | ' . ctrlp_filter_greps]
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(jpg|jpe?g|bmp|gif|png)$',
  \ 'dir': '\v[\/](tmp|tags)$'
  \ }

let g:rails_projections = {
  \ "app/admin/*.rb": { "command": "admin" },
  \ "app/workers/*_worker.rb": { "command": "worker" },
  \ "app/validators/*_validator.rb": { "command": "validator" },
  \ "app/uploaders/*_uploader.rb": { "command": "uploader" }
  \ }

let g:expand_region_text_objects = {
  \ 'iw'  : 0,
  \ 'iW'  : 0,
  \ 'i"'  : 0,
  \ 'i''' : 0,
  \ 'i]'  : 1,
  \ 'ib'  : 1,
  \ 'iB'  : 1,
  \ 'ii'  : 0,
  \ 'aM'  : 0,
  \ 'ip'  : 0
  \ }

" }}}
