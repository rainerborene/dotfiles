"necessary on some Linux distros for pathogen to properly load bundles
filetype off

"load pathogen managed plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"case insensitive searches become sensitive with capitals
set ignorecase
set smartcase

"store lots of :cmdline history
set history=1000

set showcmd  "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

set incsearch "find the next match as we type the search
set hlsearch  "highlight searches by default

set number "add line numbers
set numberwidth=5
set showbreak=...
set wrap linebreak nolist
set listchars=tab:▸\ ,eol:¬
set textwidth=79 
set formatoptions=qrn1

"disable visual bell
set visualbell t_vb=

"always show status line
set laststatus=2

"useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

"indent settings
set autoindent
set smartindent
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab

"hide buffers when not displayed
set hidden

"add some line space for easy reading
set linespace=4

"spell checking languages
set spelllang=pt,en

"tell the term has 256 colors
set t_Co=256      

if has("gui_running")
  set background=dark
  colorscheme solarized

  set guioptions-=T "don't show toolbar in the GUI
  set guioptions-=r "turn off right scroll bar
  set guioptions-=L "turn off left scroll bar
  set lines=999 columns=999 

  if has("mac")
    set guifont=Monaco:h14
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 11
  endif
else
  colorscheme customgithub
endif

"turn on syntax highlighting
syntax on

"highlight current line
set cursorline

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"handful abbreveations
cab W  w
cab Wq wq
cab wQ wq
cab WQ wq
cab Q  q

"because escape is too far away
imap jj <ESC>

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

"vimgrep navigation
map <F3> :cnext<CR>
map <F4> :cc<CR>
map <F5> :cprev<CR>

map \\ <Plug>NERDCommenterInvert

let g:NERDCreateDefaultMappings = 0 "disable default mappings
let g:NERDSpaceDelims = 1           "extra space after and before delimiter

"using another leader mapping
let mapleader = ","

"clear search highlight
nmap <silent> <leader>n :silent :nohlsearch<CR>

"map to bufexplorer
map <silent> <F11> :if exists(":BufExplorer")<Bar>exe "BufExplorer"<Bar>else<Bar>buffers<Bar>endif<CR>

"ack searching
nmap <Leader>a <Esc>:Ack

"open directory dirname of current file
map <Leader>e :e <C-R>=expand("%:p:h") . '/' <CR>

"map to CommandT TextMate style finder
nnoremap <leader>t :CommandT<CR>

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

"delete a buffer without closing the window
nmap <leader>q <Plug>Kwbd

"wipe all buffers which are not active
nmap <leader>hq <Plug>CloseHiddenBuffers

"markdown to html
nmap <leader>md :%!Markdown.pl --html4tags <cr>

" Don't use Ex mode; use Q for formatting
map Q gqj

"make Y consistent with C and D
nnoremap Y y$

"speed up buffer switching
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l

"sane movement with wrap turned on
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

if has("autocmd")
  autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim,js setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType php,apache,sql setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType markdown setlocal wrap linebreak nolist 
  autocmd FileType gitcommit setlocal spell
  autocmd BufNewFile,BufRead Rakefile,Capfile,Gemfile,Termfile,config.ru setfiletype ruby

  "apply any changes on .vimrc automatically
  autocmd bufwritepost .vimrc source $MYVIMRC

  "remove trailing whitespaces and ^M chars
  autocmd FileType html,xml,js,css,php autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
endif

set wildmode=list:longest     "make cmdline tab completion similar to bash
set wildignore+=.git,*.pyc,*~ "stuff to ignore when searching and tab completing

let g:netrw_list_hide='^\.,.\(pyc\|pyo\)$'

"keep swap files in one location
set backupdir=$HOME/.dotfiles/vim/tmp
set directory=$HOME/.dotfiles/vim/tmp

let g:ackprg="ack-grep -H --nocolor --nogroup --column"

let g:Gitv_WipeAllOnClose = 1

"use local vimrc if available
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif