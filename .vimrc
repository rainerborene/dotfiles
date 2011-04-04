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

"ignore case when searching
set ignorecase

"store lots of :cmdline history
set history=1000

set showcmd "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

set incsearch "find the next match as we type the search
set hlsearch "highlight searches by default

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

"enable 256 colors in vim
set t_Co=256

if has("gui_running")
  set guioptions-=T "turn off needless toolbar on gvim/mvim
  set guifont=bitstream\ vera\ sans\ mono\ 11 "downloaded on http://www.dafont.com/bitstream-vera-mono.font 
endif

"turn on syntax highlighting
syntax on

"the best color scheme
colorscheme vibrantink

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

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"vimgrep key-mappings
map <F3> :cnext<CR>
map <F4> :cc<CR>
map <F5> :cprev<CR>

"using another leader mapping
let mapleader = ","

"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>

"map to CommandT TextMate style finder
nnoremap <leader>o :CommandT<CR>

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

"delete a buffer without closing the window
nmap <leader>q <Plug>Kwbd

if has("autocmd")
  autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType markdown setlocal wrap linebreak nolist

  "apply any changes on .vimrc automatically
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

set wildmode=list:longest     "make cmdline tab completion similar to bash
set wildignore+=.git,*.pyc,*~ "stuff to ignore when searching and tab completing

"keep swap files in one location
set backupdir=$HOME/.vim/tmp
set directory=$HOME/.vim/tmp

"zencoding plugin settings
let g:user_zen_settings = {
\ 'indentation' : '  '
\}
