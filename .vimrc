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
set hlsearch "hilight searches by default

set number "add line numbers
set showbreak=...
set wrap linebreak nolist

"add some line space for easy reading
set linespace=4

"disable visual bell
set visualbell t_vb=

"indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"hide buffers when not displayed
set hidden

"turn off needless toolbar on gvim/mvim
set guioptions-=T

"turn on syntax highlighting
syntax on

"the best color scheme
colorscheme mac_classic

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

"map to CommandT TextMate style finder
nnoremap <leader>t :CommandT<CR>

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

"delete a buffer without closing the window
nmap <C-Q>! <Plug>Kwbd

"apply any changes on .vimrc automatically
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif
