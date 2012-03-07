" Basic configuration {{{

filetype off        " necessary on some Linux distros for pathogen to properly load bundles
set nocompatible    " use Vim settings, rather then Vi settings (much better!)
set history=1000    " store lots of :cmdline history
set autoread        " reload files (local changes only)
set autowrite       " write the contents of the file
set hidden          " hide buffers when not displayed
set spelllang=pt,en " spell checking languages
set encoding=utf-8  " default encoding
set nobomb
set undoreload=10000
set undofile
set clipboard=unnamed
set ttimeout
set nottimeout
set ttyfast
set splitbelow
set splitright
set lazyredraw
set dictionary=/usr/share/dict/words

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin on
filetype indent on

" }}}
" User Interface {{{

syntax on                           " turn on syntax highlighting
set t_Co=256                        " tell the term has 256 colors
set title                           " show the filename in the window titlebar
set cursorline                      " highlight current line
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set showcmd                         " show incomplete cmds down the bottom
set showmode                        " show current mode down the bottom
set wildmenu                        " turn on wild menu
set wildmode=list:longest,full      " make cmdline tab completion similar to bash
set wildignore+=*~,.git,*.pyc,*.o,tags
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.DS_Store?
set noshowmode
set number
set numberwidth=5
set pumheight=10
set showbreak=↪
set pastetoggle=<F6>
set background=dark
set virtualedit+=block
set shortmess=atI
set mousemodel=popup

if has("mouse")
  set mouse=a
endif

if has("gui_running")
  " Remove all the UI cruft
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R

  colorscheme badwolf

  if has("mac")
    set guifont=Menlo:h12
    set fuoptions=maxvert,maxhorz
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 9
    set lines=999 columns=999
  endif
else
  colorscheme tir_black
  highlight DiffAdd cterm=none ctermfg=black ctermbg=Green gui=none guifg=black guibg=Green
  highlight DiffDelete cterm=none ctermfg=black ctermbg=Red gui=none guifg=black guibg=Red
  highlight DiffChange cterm=none ctermfg=black ctermbg=Yellow gui=none guifg=black guibg=Yellow
  highlight DiffText cterm=none ctermfg=black ctermbg=Magenta gui=none guifg=black guibg=Magenta
end

" }}}
" Backups {{{

set undodir=$HOME/.dotfiles/vim/tmp/undo
set backupdir=$HOME/.dotfiles/vim/tmp/backup
set directory=$HOME/.dotfiles/vim/tmp/swap
set noswapfile
set backup

" }}}
" Visual Cues {{{

set visualbell t_vb=                " disable visual bell
set ignorecase                      " case insensitive
set smartcase                       " sensitive with capitals
set foldmethod=indent               " fold based on indent
set foldnestmax=3                   " deepest fold is 3 levels
set nofoldenable                    " dont fold by default
set laststatus=2                    " always show status line
set incsearch                       " find the next match as we type the search
set hlsearch                        " highlight searches by default
set nostartofline                   " don't reset cursor to start of line when moving around
set gdefault
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set fillchars=vert:\│
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

" }}}
" Text Formatting {{{

set autoindent
set smartindent
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set textwidth=80
set formatoptions=qrn1
set linespace=4
set nojoinspaces
set wrap linebreak nolist

" }}}
" Auto Commands {{{

autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim,js setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType php,apache,sql,xslt setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType markdown setlocal wrap linebreak nolist
autocmd FileType gitcommit setlocal spell | wincmd K
autocmd FileType html,xml,js,css,php autocmd BufWritePre <buffer> :call StripWhitespace()
autocmd FileType java silent! compiler javac | setlocal makeprg=javac\ %
autocmd FileType ruby silent! compiler ruby | setlocal foldmethod=syntax
autocmd FileType c setlocal foldmethod=syntax

autocmd BufNewFile,BufRead *.rss setfiletype xml
autocmd BufNewFile,BufRead *.json setfiletype javascript
autocmd BufNewFile,BufRead {Rakefile,Vagrantfile,Guardfile,Capfile,Thorfile,Gemfile,config.ru,pryrc} setfiletype ruby
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufWritePost .vimrc source $MYVIMRC

" Use <localleader>1/2/3 to add headings.
autocmd Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
autocmd Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
autocmd Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>

autocmd FileType vim setlocal foldmethod=marker
autocmd FileType help setlocal textwidth=78
autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif

autocmd FileType javascript setlocal foldmethod=marker
autocmd FileType javascript setlocal foldmarker={,}

autocmd FileType nginx setlocal foldmethod=marker foldmarker={,}

" Save when losing focus
autocmd FocusLost * :silent! wall

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" Only show cursorline in the current window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" }}}
" Mappings {{{

" Leader keys
let mapleader = ","
let maplocalleader = "\\"

" Easier bracket matching
map <Tab> %

" Delete a buffer without closing the window
nmap <leader>q <Plug>Kwbd

" Wipe all buffers which are not active
nmap <leader>hq <Plug>CloseHiddenBuffers

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Keep search matches in the middle of the window and pulse the line when moving
" To them.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Make Y consistent with C and D
nnoremap Y y$

" Shortcuts for visual selections
nnoremap gV `[v`]`

" Save a file as root.
cnoremap w!! w !sudo tee % >/dev/null

" Enter command mode quickly
nnoremap ; :

" Fuck you, help key.
noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

" Fuck you too, manual key.
nnoremap K <nop>

" Kill window
nnoremap K :q<cr>

" Speed up buffer switching
noremap <C-k> <C-W>k
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <leader>v <C-w>v

" Omnicompletion
inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>

" Sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
vnoremap <Up> gk
vnoremap <Down> gj
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj

" Handful abbreveations
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q
cab git Git

iabbrev me@ me@rainerborene.com
iabbrev #e # encoding: utf-8

" Calculator
inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Substitute
nnoremap <leader>s :%s//<left>

" Source
vnoremap <leader>S y:execute @@<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>

" Regenerate ctags
nnoremap <leader>rt :!ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Because escape is too far away
inoremap jj <ESC>

" Shortcut for []
onoremap id i[
onoremap ad a[
vnoremap id i[
vnoremap ad a[

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" Cursor happens to be.
nnoremap zO zCzO

" Duplication
nnoremap <leader>d mz"dyy"dp`z
vnoremap <leader>d "dymz"dP`z``

" Clear search highlight
nnoremap <silent> <leader>/ :silent :nohlsearch<CR>

" Open directory dirname of current file
noremap <Leader>e :e <C-R>=expand("%:p:h") . '/' <CR>

" Open ctrlp in buffer and tag mode
nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

" Toggle commands
nnoremap <leader>I :set list!<CR>
nnoremap <leader>p :set invpaste<CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <silent> <leader>n :NERDTree<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>
nnoremap <silent> <buffer> <leader>l :set spell!<CR>

" Ack searching
noremap <leader>a :Ack!

" Align text
nnoremap <leader>Al :left<cr>
nnoremap <leader>Ac :center<cr>
nnoremap <leader>Ar :right<cr>
vnoremap <leader>Al :left<cr>
vnoremap <leader>Ac :center<cr>
vnoremap <leader>Ar :right<cr>

" Fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gh :Gbrowse<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gv :Gitv --all<cr>
nnoremap <leader>gV :Gitv! --all<cr>

" Strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>w :call StripWhitespace()<CR>

" Visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" }}}
" Quick editing {{{

nnoremap <silent> <leader>ez :e ~/.zshrc<CR>
nnoremap <silent> <leader>es :e ~/.vim/snippets/<CR>
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>rv :so $MYVIMRC<CR>

" }}}
" Global Options {{{

let g:ruby_path=$RUBY_BIN
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeMinimalUI = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDTreeDirArrows = 1
let g:NERDSpaceDelims = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_OpenHorizontal = 1
let g:ackprg = "ack-grep -H --nocolor --nogroup --column"
let g:sparkupNextMapping = '<c-s>'
let g:gundo_preview_bottom = 1
let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit  =  1
let g:ctrlp_extensions = ['tag']
let g:Powerline_symbols = "fancy"
let g:syntastic_enable_signs = 1
let g:syntastic_quiet_warnings = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_disabled_filetypes = ['html']
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" }}}
