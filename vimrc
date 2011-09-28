" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

filetype off        " necessary on some Linux distros for pathogen to properly load bundles
set nocompatible    " use Vim settings, rather then Vi settings (much better!)
set history=1000    " store lots of :cmdline history
set autoread        " reload files (local changes only)
set hidden          " hide buffers when not displayed
set spelllang=pt,en " spell checking languages

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin on
filetype indent on

" ---------------------------------------------------------------------------
" User Interface
" ---------------------------------------------------------------------------

syntax on                           " turn on syntax highlighting
set cursorline                      " highlight current line
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set showcmd                         " show incomplete cmds down the bottom
set showmode                        " show current mode down the bottom
set wildmenu                        " turn on wild menu
set wildmode=list:longest           " make cmdline tab completion similar to bash
set wildignore+=.git,*.pyc,*~       " stuff to ignore when searching and tab completing
set wildignore+=*.png,*.gif,*.jpg   " normal people don't edit images using a text editor
set t_Co=256                        " tell the term has 256 colors
set number 
set numberwidth=5
set showbreak=...
set background=dark 
colorscheme tir_black

if has("gui_running")
  set guioptions-=T                 " don't show toolbar in the GUI
  set guioptions-=r                 " turn off right scroll bar
  set guioptions-=L                 " turn off left scroll bar
  set lines=999 columns=999 
  colorscheme ir_black

  if has("mac")
    set guifont=Menlo:h14
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 11
  endif
endif

" ---------------------------------------------------------------------------
" Backups
" ---------------------------------------------------------------------------

set backupdir=$HOME/.dotfiles/vim/tmp
set directory=$HOME/.dotfiles/vim/tmp

" ---------------------------------------------------------------------------
" Visual Cues
" ---------------------------------------------------------------------------

set visualbell t_vb=                " disable visual bell
set ignorecase                      " case insensitive
set smartcase                       " sensitive with capitals
set foldmethod=indent               " fold based on indent
set foldnestmax=3                   " deepest fold is 3 levels
set nofoldenable                    " dont fold by default
set laststatus=2                    " always show status line
set incsearch                       " find the next match as we type the search
set hlsearch                        " highlight searches by default
set scrolloff=3
set sidescrolloff=7
set sidescroll=1
set listchars=tab:▸\ ,eol:¬
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%=%-16(\ %l,%c-%v\ %)%P

" ---------------------------------------------------------------------------
" Text Formatting
" ---------------------------------------------------------------------------

set autoindent
set smartindent
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set textwidth=79 
set formatoptions=qrn1
set linespace=4
set wrap linebreak nolist

" ---------------------------------------------------------------------------
" Auto Commands
" ---------------------------------------------------------------------------

autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim,js setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType php,apache,sql setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType markdown setlocal wrap linebreak nolist 
autocmd FileType gitcommit setlocal spell
autocmd FileType html,xml,js,css,php autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd FileType java silent! compiler javac | setlocal makeprg=javac\ %
autocmd FileType ruby silent! compiler ruby

autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead Rakefile,Capfile,Gemfile,config.ru setfiletype ruby
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufWritePost .vimrc source $MYVIMRC

" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

" using another leader mapping
let mapleader = ","

" delete a buffer without closing the window
nmap <leader>q <Plug>Kwbd

" wipe all buffers which are not active
nmap <leader>hq <Plug>CloseHiddenBuffers

" markdown to html
nmap <leader>md :%!Markdown.pl --html4tags <cr>

" don't use Ex mode; use Q for formatting
map Q gqj

" make Y consistent with C and D
nnoremap Y y$ 

" speed up buffer switching
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l

" sane movement with wrap turned on
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

" handful abbreveations
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

" because escape is too far away
imap jj <ESC>

" key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

" clear search highlight
nmap <silent> <leader>h :silent :nohlsearch<CR>

" map to bufexplorer
map <silent> <F11> :if exists(":BufExplorer")<Bar>exe "BufExplorer"<Bar>else<Bar>buffers<Bar>endif<CR>

" ack searching
map <Leader>a <Esc>:Ack

" open directory dirname of current file
map <Leader>e :e <C-R>=expand("%:p:h") . '/' <CR>

" map to CommandT TextMate style finder
nnoremap <leader>t :CommandT<CR>

" some toggle commands
map <Leader>u :GundoToggle<CR>
map <silent> <Leader>n :NERDTreeToggle<CR>

" ---------------------------------------------------------------------------
" Global Variables
" ---------------------------------------------------------------------------

let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=0
let g:NERDCreateDefaultMappings=0
let g:NERDTreeDirArrows=1
let g:NERDSpaceDelims=1
let g:Gitv_WipeAllOnClose=1
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
