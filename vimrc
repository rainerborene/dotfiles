" Basic settings {{{

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
set shiftround
set ttimeout
set nottimeout
set ttyfast
set splitbelow
set splitright
set lazyredraw
set matchtime=3
set dictionary=/usr/share/dict/words

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin on
filetype indent on

" }}}
" Appearance {{{

syntax on                           " turn on syntax highlighting
set t_Co=256                        " tell the term has 256 colors
set title                           " show the filename in the window titlebar
set cursorline                      " highlight current line
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set showcmd                         " show incomplete cmds down the bottom
set noshowmode                      " hide current mode down the bottom
set wildmenu                        " turn on wild menu
set wildmode=list:longest,full      " make cmdline tab completion similar to bash
set wildignore+=*~,.git,*.pyc,*.o,tags
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.DS_Store
set wildignore+=.sass-cache
set number
set numberwidth=5
set pumheight=10
set showbreak=↪
set pastetoggle=<F6>
set background=dark
set virtualedit+=block
set shortmess=atI
set mousemodel=popup
set completeopt=longest,menuone,preview

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

  let g:badwolf_html_link_underline = 0
  colorscheme badwolf
  highlight SpellBad term=underline gui=undercurl guisp=Orange

  if has("mac")
    set guifont=Menlo:h12
    set fuoptions=maxvert,maxhorz
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 9
    set lines=999 columns=999
  endif
else
  set clipboard=unnamed
  colorscheme tir_black
end

" }}}
" Backups {{{

set undodir=$HOME/.dotfiles/vim/tmp/undo//
set backupdir=$HOME/.dotfiles/vim/tmp/backup//
set directory=$HOME/.dotfiles/vim/tmp/swap//
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
set linespace=1
set nojoinspaces
set wrap linebreak nolist

" }}}
" Auto Commands {{{

au FileType html,css,scss,ruby,pml,yaml,coffee,vim,js setlocal ts=2 sts=2 sw=2 expandtab
au FileType php,apache,sql,xslt,gitconfig setlocal ts=4 sts=4 sw=4 noexpandtab
au FileType python setlocal ts=4 sts=4 sw=4 expandtab
au FileType markdown setlocal wrap linebreak nolist
au FileType gitcommit setlocal spell | wincmd K
au FileType html,xml,js,css,php autocmd BufWritePre <buffer> :call StripWhitespace()
au FileType java silent! compiler javac | setlocal makeprg=javac\ %
au FileType ruby silent! compiler ruby | setlocal foldmethod=syntax
au FileType c setlocal foldmethod=syntax

au BufNewFile,BufRead *.rss setfiletype xml
au BufNewFile,BufRead *.json setfiletype javascript
au BufNewFile,BufRead {Rakefile,Vagrantfile,Guardfile,Capfile,Thorfile,Gemfile,pryrc,config.ru} setfiletype ruby
au BufReadPost fugitive://* set bufhidden=delete
au BufWritePost .vimrc source $MYVIMRC

augroup ft_markdown
  au!
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown
  au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
  au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
  au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
augroup END

augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

augroup ft_javascript
  au!
  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}
augroup END

" Only show cursorline in the current window
augroup cline
  au!
  au WinLeave * set nocursorline
  au WinEnter * set cursorline
  au InsertEnter * set colorcolumn=80
  au InsertLeave * set colorcolumn&
augroup END

" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Make terminal Vim trigger autoread more often.
au WinEnter,BufWinEnter,CursorHold * checktime

" Restore cursor position
au BufReadPost *
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
nnoremap ? ?\v
vnoremap ? ?\v

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Keep the cursor in place while joining limes
nnoremap J mzJ`z

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Make Y consistent with C and D
nnoremap Y y$

" Shortcuts for visual selections
nnoremap gV `[v`]

" Save a file as root.
cnoremap w!! w !sudo tee % >/dev/null

" Enter command mode quickly
nnoremap ; :

" Cmdheight switching
nnoremap <leader>1 :set cmdheight=1<cr>
nnoremap <leader>2 :set cmdheight=2<cr>

" Fuck you, help key.
noremap <F1> :set invfullscreen<CR>
inoremap <F1> <ESC>:set invfullscreen<CR>a

" Fuck you too, manual key.
nnoremap K <nop>

" Kill window
nnoremap K :q<cr>

" I hate when the rendering occasionally gets messed up.
nnoremap <leader>rr :redraw!<cr>

" Speed up buffer switching
noremap <C-k> <C-W>k
noremap <C-j> <C-W>j
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <leader>v <C-w>v

" Easy filetype switching
nnoremap _ss :setf sass<CR>
nnoremap _ht :setf html<CR>
nnoremap _vi :setf vim<CR>
nnoremap _rb :setf ruby<CR>

" View full list of vim's syntax groups
nnoremap <leader>hi :source $VIMRUNTIME/syntax/hitest.vim<CR>

" Omni completion
inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>

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

" Send visual selection to sprunge.us
vnoremap <leader>G :w !curl -sF 'sprunge=<-' 'http://sprunge.us' \| tr -d '\n ' \| pbcopy<cr>

" Jump to line and column
noremap ' `

" Regenerate ctags
nnoremap <leader>rt :silent !/usr/local/bin/ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Because escape is too far away
inoremap jj <ESC>

" Shortcut for [] and double quotes
onoremap id i[
onoremap ad a[
vnoremap id i[
vnoremap ad a[
onoremap iq i"
onoremap aq a"
vnoremap iq i"
vnoremap aq a"

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" Cursor happens to be.
nnoremap zO zCzO

" Focus the current fold by folding all the others
nnoremap <leader>z zMzvzz

" Duplication
nnoremap <leader>d mz"dyy"dp`z
vnoremap <leader>d "dymz"dP`z``

" Diffoff
nnoremap <leader>D :diffoff!<cr>

" Clear search highlight
nnoremap <silent> <leader>/ :silent :nohlsearch<CR>

" Open directory dirname of current file
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . '/' <CR>

" Open ctrlp in buffer and tag mode
nnoremap <Leader>t :CtrlPTag<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

" Toggle commands
nnoremap <leader>i :set list!<CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <silent> <leader>n :NERDTree<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>
nnoremap <silent> <leader>l :set spell!<CR>

" Yank to OS X pasteboard.
noremap <leader>y "*y

" Paste from OS X pasteboard without messing up indent.
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

" Ack searching
noremap <leader>a :Ack!<space>

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
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gh :Gbrowse<cr>
nnoremap <leader>gco :Gread<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<space>
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
" Synstack {{{

" Show highlighting groups for current word
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc
nnoremap <F7> :call SynStack()<CR>

" }}}
" Scratch {{{

function! ScratchToggle()
  if exists("w:is_scratch_window")
    unlet w:is_scratch_window
    exec "q"
  else
    exec "normal! :Sscratch\<cr>\<C-W>J:resize 13\<cr>"
    let w:is_scratch_window = 1
  endif
endfunction
command! ScratchToggle call ScratchToggle()
nnoremap <silent> <leader><tab> :ScratchToggle<cr>

" }}}
" Quick editing {{{

nnoremap <silent> <leader>et :e ~/tasks.txt<CR>
nnoremap <silent> <leader>ez :e ~/.zshrc<CR>
nnoremap <silent> <leader>ex :e ~/.tmux.conf<CR>
nnoremap <silent> <leader>es :e ~/.vim/snippets/<CR>
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>rv :so $MYVIMRC<CR>

" }}}
" Global Options {{{

let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
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
let g:ctrlp_clear_cache_on_exit = 1
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
