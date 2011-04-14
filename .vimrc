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
set smartcase

"store lots of :cmdline history
set history=1000

set showcmd  "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

set incsearch "find the next match as we type the search
set hlsearch  "highlight searches by default

set number "add line numbers
set showbreak=...
set wrap linebreak nolist
set listchars=tab:▸\ ,eol:¬

"disable visual bell
set visualbell t_vb=

"always show status line
set laststatus=2

"useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"hide buffers when not displayed
set hidden

"add some line space for easy reading
set linespace=4

"spell checking languages
set spelllang=pt,en

if has("gui_running")
  set t_Co=256      "tell the term has 256 colors
  set guioptions-=T "turn off needless toolbar on gvim/mvim
  
  if has("mac")
    set guifont=Monaco:h14
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 11
  endif
endif

"turn on syntax highlighting
syntax on

"my favorite color scheme
colorscheme vividchalk

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

"nerdcommenter settings
map \\ <Plug>NERDCommenterInvert
let g:NERDCreateDefaultMappings = 0 "disable default mappings
let g:NERDSpaceDelims = 1           "extra space after and before delimiter

"using another leader mapping
let mapleader = ","

"toggle spell checking option
nmap <silent> <buffer> <leader>s :set spell!<CR>

"clear search highlight
nmap <silent> <leader>n :silent :nohlsearch<CR>

"map to bufexplorer
map <silent> <F11> :if exists(":BufExplorer")<Bar>exe "BufExplorer"<Bar>else<Bar>buffers<Bar>endif<CR>

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

if has("autocmd")
  autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType markdown setlocal wrap linebreak nolist 
  autocmd FileType gitcommit setlocal spell

  "apply any changes on .vimrc automatically
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

set wildmode=list:longest     "make cmdline tab completion similar to bash
set wildignore+=.git,*.pyc,*~ "stuff to ignore when searching and tab completing

"keep swap files in one location
set backupdir=$HOME/.vim/tmp
set directory=$HOME/.vim/tmp

let g:ackprg="ack-grep -H --nocolor --nogroup --column"
