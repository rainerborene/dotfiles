" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

filetype off        " necessary on some Linux distros for pathogen to properly load bundles
set nocompatible    " use Vim settings, rather then Vi settings (much better!)
set history=1000    " store lots of :cmdline history
set autoread        " reload files (local changes only)
set hidden          " hide buffers when not displayed
set spelllang=pt,en " spell checking languages
set encoding=utf-8  " default encoding
set nobomb

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin on
filetype indent on

" ---------------------------------------------------------------------------
" UI
" ---------------------------------------------------------------------------

syntax on                           " turn on syntax highlighting
set t_Co=256                        " tell the term has 256 colors
set title                           " show the filename in the window titlebar
set cursorline                      " highlight current line
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set showcmd                         " show incomplete cmds down the bottom
set showmode                        " show current mode down the bottom
set wildmenu                        " turn on wild menu
set wildmode=list:longest           " make cmdline tab completion similar to bash
set wildignore+=*~,.git,*.pyc,*.o,tags
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.DS_Store?
set number
set numberwidth=5
set showbreak=↪
set pastetoggle=<F8>
set background=dark

if has('mouse')
  set mouse=a
endif

if has("gui_running")
  " Remove all the UI cruft
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R

  set lines=999 columns=999
  colorscheme ir_black

  if has("mac")
    set guifont=Menlo:h12
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 9
  endif
else
  colorscheme tir_black
  
  " default vimdiff color schemes are bad!
  highlight DiffAdd cterm=none ctermfg=bg ctermbg=Green gui=none guifg=bg guibg=Green 
  highlight DiffDelete cterm=none ctermfg=bg ctermbg=Red gui=none guifg=bg guibg=Red 
  highlight DiffChange cterm=none ctermfg=bg ctermbg=Yellow gui=none guifg=bg guibg=Yellow 
  highlight DiffText cterm=none ctermfg=bg ctermbg=Magenta gui=none guifg=bg guibg=Magenta 
end

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
set nostartofline                   " don't reset cursor to start of line when moving around
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
set textwidth=80
set formatoptions=qrn1
set linespace=4
set nojoinspaces
set wrap linebreak nolist

" ---------------------------------------------------------------------------
" Auto Commands
" ---------------------------------------------------------------------------

autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim,js setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType php,apache,sql setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType markdown setlocal wrap linebreak nolist
autocmd FileType gitcommit setlocal spell
autocmd FileType html,xml,js,css,php autocmd BufWritePre <buffer> :call StripWhitespace()
autocmd FileType java silent! compiler javac | setlocal makeprg=javac\ %
autocmd FileType ruby silent! compiler ruby

autocmd BufNewFile,BufRead *.rss setfiletype xml
autocmd BufNewFile,BufRead *.json setfiletype javascript
autocmd BufNewFile,BufRead {Rakefile,Vagrantfile,Guardfile,Capfile,Thorfile,Gemfile,config.ru} setfiletype ruby
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufWritePost .vimrc source $MYVIMRC

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

" using another leader mapping
let mapleader = ","

" use sane regexes.
nnoremap / /\v
vnoremap / /\v

" delete a buffer without closing the window
nmap <leader>q <Plug>Kwbd

" wipe all buffers which are not active
nmap <leader>hq <Plug>CloseHiddenBuffers

" markdown to html
nmap <leader>md :%!Markdown.pl --html4tags <cr>

" Formatting, TextMate-style
nnoremap Q gqip

" make Y consistent with C and D
nnoremap Y y$

" shortcuts for visual selections
nmap gV `[v`]`

" save a file as root.
cmap w!! w !sudo tee % >/dev/null

" speed up buffer switching
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
map <C-l> <C-W>l

" omnicompletion
inoremap <leader>, <C-x><C-o>
inoremap <leader>: <C-x><C-f>
inoremap <leader>= <C-x><C-l>

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

" Diffoff
nnoremap <leader>D :diffoff!<cr>

" calculator
inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" because escape is too far away
imap jj <ESC>

" key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

" clear search highlight
nmap <silent> <leader>/ :silent :nohlsearch<CR>

" map to bufexplorer
map <silent> <F11> :if exists(":BufExplorer")<Bar>exe "BufExplorer"<Bar>else<Bar>buffers<Bar>endif<CR>

" open directory dirname of current file
map <Leader>e :e <C-R>=expand("%:p:h") . '/' <CR>

" map to CommandT TextMate style finder
nnoremap <leader>t :CommandT<CR>
nnoremap <leader>T :CommandTFlush<CR>

" some toggle commands
map <Leader>u :GundoToggle<CR>
map <silent> <Leader>n :NERDTreeToggle<CR>
map <silent> <leader>N :NERDTreeFind<CR>

" ack searching
map <leader>a :Ack! 

" align text
nnoremap <leader>Al :left<cr>
nnoremap <leader>Ac :center<cr>
nnoremap <leader>Ar :right<cr>
vnoremap <leader>Al :left<cr>
vnoremap <leader>Ac :center<cr>
vnoremap <leader>Ar :right<cr>

" fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>

" strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

noremap <leader>ss :call StripWhitespace()<CR>

" ---------------------------------------------------------------------------
" Global Variables
" ---------------------------------------------------------------------------

let g:CommandTMaxHeight=20
let g:CommandTMatchWindowAtTop=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeMinimalUI=1
let g:NERDCreateDefaultMappings=0
let g:NERDTreeDirArrows=1
let g:NERDSpaceDelims=1
let g:Gitv_WipeAllOnClose=1
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
let g:sparkupNextMapping='<c-f>'
let g:SuperTabDefaultCompletionType="context"
let g:slime_target="tmux"

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
