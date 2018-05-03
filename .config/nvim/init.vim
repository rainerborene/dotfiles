" .vimrc of Rainer Borene
" =======================
" Plugged {{{

" Disable default plugins
let g:loaded_netrwPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_gzip = 1
let g:loaded_tutor_mode_plugin = 1
let g:did_install_default_menus = 1

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/sideways.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'cohama/lexima.vim'
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'glts/vim-textobj-comment'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'janko-m/vim-test'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'jreybert/vimagit', { 'on': 'Magit' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-niceblock'
Plug 'kana/vim-smartword'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-textobj-delimited'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mhinz/vim-startify'
Plug 'osyo-manga/vim-anzu'
Plug 'rhysd/vim-textobj-ruby'
Plug 'rhysd/vim-textobj-word-column'
Plug 'saaguero/vim-textobj-pastedtext'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-abolish', { 'on': ['Abolish', 'Subvert', 'S'] }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'w0ng/vim-hybrid'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'

call plug#end()

" }}}
" Basic options {{{

" misc
set confirm
set lazyredraw
set shortmess=aoOtI
set noswapfile
set nowritebackup
set spellfile=~/.config/nvim/spell/custom-dictionary.utf-8.add
set spelllang=pt,en
set undofile
set undoreload=10000
set notimeout
set ttimeout
set ttimeoutlen=0

" text manipulation
set expandtab
set formatoptions=qrn1j
set linebreak
set shiftwidth=2
set tabstop=4
set textwidth=80
set virtualedit+=block
set completeopt=longest,menuone
set inccommand=nosplit
set nojoinspaces

" better navigation
set foldlevel=99
set gdefault
set ignorecase
set smartcase
set hidden
set splitbelow
set splitright
set sidescroll=5
set nostartofline

" wild stuff
set wildmode=list:longest,full
set wildignore+=*.DS_Store
set wildignore+=*~,.git,*.pyc,*.o,*.spl,*.rdb
set wildignore+=.sass-cache

" ui customization
set list
set listchars=tab:»\ ,trail:·,extends:❯,precedes:❮
set fillchars=diff:─,vert:│
set showbreak=↪\ "
set noshowmode
set numberwidth=1
set relativenumber
set number
set conceallevel=2
set concealcursor=niv

" }}}
" Color scheme {{{

let g:terminal_color_0  = '#1e1e1e'
let g:terminal_color_1  = '#cf6a4c'
let g:terminal_color_2  = '#8f9d6a'
let g:terminal_color_3  = '#f9ee98'
let g:terminal_color_4  = '#7587a6'
let g:terminal_color_5  = '#9b859d'
let g:terminal_color_6  = '#afc4db'
let g:terminal_color_7  = '#a7a7a7'
let g:terminal_color_8  = '#5f5a60'
let g:terminal_color_9  = '#cf6a4c'
let g:terminal_color_10 = '#8f9d6a'
let g:terminal_color_11 = '#f9ee98'
let g:terminal_color_12 = '#7587a6'
let g:terminal_color_13 = '#9b859d'
let g:terminal_color_14 = '#afc4db'
let g:terminal_color_15 = '#ffffff'

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set background=dark
set termguicolors

function! s:extend_colorscheme() abort
  hi! SignColumn guibg=bg
  hi! ExtraWhitespace ctermbg=red guibg=red
  hi! EndOfBuffer guibg=bg guifg=bg
  hi! def link neosnippetExpandSnippets NonText
  hi! def link neosnippetConcealExpandSnippets NonText
  hi! Sneak gui=bold,underline cterm=bold,underline ctermfg=221 guifg=#f0c674
  hi! link SneakLabel Search
endfunction

augroup vimrc_colorscheme
  au!
  au ColorScheme * call s:extend_colorscheme()
augroup END

colorscheme hybrid

" }}}
" Statusline {{{

set statusline=%F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

" }}}
" Mappings {{{

let mapleader = ","
let maplocalleader = "\\"

" Easier bracket matching
map <Tab> %
map <C-o> <nop>

" qq to record, Q to replay
nmap Q @q

" .: repeats the last command on every line
xnoremap . :normal.<cr>

" @: repeats macro on every line
xnoremap @ :normal@

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Move to last change
nnoremap gI `.zz

" Center screen
nnoremap gg ggzv
nnoremap G Gzv

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z

" I hate when the rendering occasionally gets messed up.
nnoremap <silent> U :syntax sync fromstart<cr>:nohlsearch<cr>:redraw!<cr>

" Tab switching
nnoremap <C-p> gT
nnoremap <C-n> gt

" Split windows
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" Faster scrolling
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

" Resize window
nnoremap <left>   <c-w>>
nnoremap <right>  <c-w><
nnoremap <up>     <c-w>-
nnoremap <down>   <c-w>+

" Sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" { and } skip over closed folds instead of openning them
nnoremap <expr> } foldclosed(search('^$', 'Wn'))  == -1 ? '}zz' : '}j}zz'
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? '{zz' : '{k{zz'

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Quit
inoremap <silent> <C-Q> <esc>:q<cr>
nnoremap <silent> <C-Q> :q<cr>
nnoremap <silent> <C-W>q :q!<cr>

" Save
inoremap <silent> <C-s> <C-o>:update<cr>
nnoremap <silent> <C-s> :update<cr>

" Make Y consistent with C and D.
nnoremap Y y$

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" Focus the current fold by folding all the others
nnoremap <leader>z zMzvzz

" Show the stack of syntax highlighting classes under the cursor.
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc
nnoremap zS :call SynStack()<CR>

" Ctrl-g: Prints current file name
nnoremap <c-g> 2<c-g>

" Ctrl-b: Go (b)ack. Go to previously buffer
nnoremap <c-b> <c-^>

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-g> <C-c>

" Command-line abbreviations
cnoreabbrev Wqa wqa
cnoreabbrev W w

" Write everything and quit
nnoremap ZX :wall \| qall!<CR>

" Send to the black hole register
noremap x "_x
noremap X "_X

" Goto older/newer position in change list
nnoremap <silent> ( g;zvzz
nnoremap <silent> ) g,zvzz

" Clean trailing whitespace
nnoremap <silent> =w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

" Goto line/column instead
noremap ' `

" Fast access to some registers
noremap! <c-r>/ <c-r>=substitute(getreg('/'), '[<>\\]', '', 'g')<cr>
noremap! <c-r>w <c-r>=expand("<cword>")<cr>

" Change current word and prepare to repeat next occurence (like *cgn)
nnoremap c* :<C-U>let @/='\<'.expand("<cword>").'\>'<CR>:set hlsearch<CR>cgn

" Mark position before search
nnoremap / ms/

" Replace alias
nnoremap s/ mr:%s/

" Repeat last substitution
nnoremap & n:&&<cr>
xnoremap & n:&&<cr>

" Reindent entire file
nnoremap == mqHmwgg=G`wzt`q

" Easy filetype switching
nnoremap =f :setfiletype<Space>

" Insert Mode Completion
imap <c-j> <c-n>
imap <c-k> <c-p>

" }}}
" Zoom {{{

function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" }}}
" Ctags generation {{{

function! s:generate_ctags() abort
  if &ft == "ruby" && executable("ripper-tags")
    call system("ripper-tags -R &")
  else
    call system("ctags -R . &")
  end
  redraw!
endfunction
nnoremap <silent> g<cr> :call <sid>generate_ctags()<cr>

" }}}
" Quickfix mode {{{

function! s:qf_toggle()
  let nr = winnr("$")
  if len(getqflist()) > 0
    copen
  end
  if nr == winnr("$")
    cclose
  endif
endfunction

" Close quickfix/location window
nnoremap <silent> <leader>c :call <sid>qf_toggle()<cr>

function! s:qf_define_mappings() abort
  nnoremap <buffer> <silent> q :<C-u>cclose<CR>
  nnoremap <buffer> <silent> <c-n> :<C-u>cnext<CR>:copen<CR>
  nnoremap <buffer> <silent> <c-p> :<C-u>cprevious<CR>:copen<CR>
endfunction

augroup ft_qf
  au!
  au FileType qf setlocal nowrap nonumber norelativenumber | wincmd J
  au FileType qf call s:qf_define_mappings()

  " Automatically opens the quickfix window after :Ggrep.
  au QuickFixCmdPost *grep* cwindow
augroup END

" }}}
" Autocommands {{{

augroup ft_postgres
  au!
  au BufNewFile,BufRead /tmp/sql*,*.sql,*psql* set filetype=pgsql
  au FileType pgsql set softtabstop=2 shiftwidth=2
  au FileType pgsql set foldmethod=indent
  au FileType pgsql setlocal commentstring=--\ %s comments=:--
augroup END

augroup ft_nginx
  au!
  au FileType nginx setlocal foldmethod=marker foldmarker={,}
augroup END

augroup ft_javascript
  au!
  au BufNewFile,BufRead *.es6 set filetype=javascript
  au BufNewFile,BufRead .jshintrc,.babelrc,.eslintrc set filetype=json
  au FileType javascript setlocal foldmethod=marker foldmarker={,}
  au FileType json nnoremap <buffer> == gggqG
augroup END

augroup ft_html
  au!
  au FileType html,eruby setlocal foldmethod=manual
  au FileType html,eruby nnoremap <buffer> <localleader>f Vatzf
  au FileType html,eruby nnoremap <buffer> <localleader>= Vat=
augroup END

augroup ft_xml
  au!
  au FileType xml let &l:equalprg='xmllint --format --recover - 2>/dev/null'
augroup END

augroup ft_awk
  au!
  au FileType awk setlocal commentstring=#\ %s
augroup END

augroup ft_markdown
  au!
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1
  au FileType markdown nnoremap <buffer> <localleader>1 yypVr=
  au FileType markdown nnoremap <buffer> <localleader>2 yypVr-
  au FileType markdown nnoremap <buffer> <localleader>3 I### <ESC>
  au FileType markdown setlocal wrap linebreak nolist
augroup END

augroup ft_css
  au!
  au FileType css,scss setlocal foldmethod=marker foldmarker={,}
  au FileType css,scss,sass setlocal iskeyword+=-
augroup END

augroup ft_haml
  au!
  au FileType haml setlocal iskeyword+=-
augroup END

augroup ft_ruby
  au!
  au BufRead *gemrc setlocal filetype=yaml
  au FileType ruby setlocal iskeyword+=!,?
  au FileType ruby setlocal keywordprg=ri\ -T
  au BufNewFile,BufRead .env* set filetype=sh
augroup END

augroup ft_tmux
  au!
  au FileType tmux setlocal foldmethod=marker
augroup END

augroup vimrc
  au!
  au BufWritePost init.vim nested if expand('%') !~ 'fugitive' | source % | endif
  au FileType vim setlocal foldmethod=marker keywordprg=:help

  " Highlight cursor when inactive
  au CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  au CursorHold,CursorHoldI,WinEnter * setlocal cursorline

  " File type detection
  au BufWritePost *
        \  if &l:filetype ==# '' || exists('b:ftdetect')
        \|   unlet! b:ftdetect
        \|   filetype detect
        \| endif

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " More focus on trailing white spaces
  autocmd InsertEnter * set listchars-=trail:⣿
  autocmd InsertLeave * set listchars+=trail:⣿

  " Save when losing focus
  au FocusLost * :silent! wall

  " Resize splits when the window is resized
  au VimResized * :wincmd =

  " No folds closed when editing new files
  au BufNew * setlocal foldlevelstart=99

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Don't keep undo files in temp directories or shm
  au BufWritePre /tmp/* setlocal noundofile

  " Don't keep viminfo for files in temp directories or shm
  au BufNewFile,BufReadPre /tmp/* setlocal viminfo=

  " Always show sign column
  au BufEnter *
        \  if !exists("b:signed_column") && filereadable(expand("%")) && &ft !~ "git"
        \|   setlocal signcolumn=yes
        \|   let b:signed_column = 1
        \| endif

  " Restore cursor position
  au BufReadPost *
        \  if line("'\"") > 1 && line("'\"") <= line("$")
        \|   exe "normal! g`\""
        \| endif

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au VimLeave * call system('tmux set-window automatic-rename on')
    au BufEnter *
          \  if empty(&buftype)
          \|   call system('tmux rename-window '.expand('%:t:S'))
          \| endif
  endif
augroup END

" }}}
" Help in new tabs {{{

function! s:helptab()
  if &buftype == 'help'
    wincmd T
    setlocal nolist
    nnoremap <buffer> q :q<cr>
  endif
endfunction

augroup vimrc_help
  au!
  au BufEnter *.txt call s:helptab()
augroup END

" }}}
" Folding {{{

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
" Automatically create any non-existent directories before writing the buffer {{{

function! s:Mkdir()
  let dir = expand('%:p:h')
  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction
autocmd BufWritePre * call s:Mkdir()

" }}}
" Plugins {{{

" Ruby {{{

let g:ruby_operators = 1
let g:ruby_fold = 1

" }}}
" NERDTree {{{

let g:NERDTreeHijackNetrw = 1
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapJumpFirstChild = 'gK'
let g:NERDTreeMapJumpNextSibling = 'gj'
let g:NERDTreeMapJumpPrevSibling = 'gk'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1

augroup nerd_loader
  au!
  au FileType nerdtree setlocal colorcolumn& nowrap tw=0
  au BufEnter,BufNew *
        \ if isdirectory(expand('<amatch>')) |
        \   call plug#load('nerdtree') |
        \   execute 'autocmd! nerd_loader' |
        \ endif
augroup END

" Open NERDTree file explorer
nnoremap <leader>e :e <c-r>=expand('%:p:h') . '/'<cr><cr>

" }}}
" Switch {{{

let g:switch_mapping = "-"
let g:my_switch_definitions = {}
let g:my_switch_definitions.scss = [['right', 'left']]
let g:my_switch_definitions.ruby = [['has_key?', 'key?']]
let g:my_switch_definitions.javascript = [
      \ {
      \   '\[["'']\(\k\+\)["'']\]': '\.\1',
      \   '\.\(\k\+\)': '[''\1'']'
      \ }]

" Global
let g:switch_custom_definitions = [
      \ {
      \   '\v"([^''"]+)"': "'\\1'",
      \   '\v''([^''"]+)''': '"\1"'
      \ }]

augroup switch
  au!
  au FileType * let b:switch_custom_definitions = get(g:my_switch_definitions, &ft, [])
augroup END

" }}}
" Undotree {{{

let g:undotree_WindowLayout = 2

nnoremap <silent> <leader>u :UndotreeToggle<CR>

" }}}
" FZF {{{

let $FZF_DEFAULT_OPTS .= ' --inline-info'

let g:fzf_layout = { 'down': '20%' }
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

augroup ft_fzf
  au!
  au FileType fzf nnoremap <silent> <buffer> <c-g> :q<cr>

  " Hide statusline of terminal buffer
  au FileType fzf set laststatus=0 | au BufLeave <buffer> set laststatus=2

  au TermOpen term://*FZF tnoremap <silent> <buffer> <nowait> <esc> <c-c>
augroup END

command! -nargs=+ -complete=file Rg
      \ call fzf#vim#grep(
      \   'rg --hidden --vimgrep --smart-case --color=always '. <q-args>, 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <expr> <c-x><c-j> fzf#vim#complete#path('rg --files --hidden')

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>. :Tags<CR>
nnoremap <leader>a :Rg<Space>

" }}}
" Fugitive {{{

nnoremap <silent> <leader>gd :Gvdiff -<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gl :Glog<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>
nmap <silent> <leader>gs :Gstatus<cr>gg<c-n>

augroup ft_git
  au!
  au FileType git nnoremap <buffer> <c-n> zMzjzOzt
  au FileType git nnoremap <buffer> <c-p> zMzkzO[zzt
  au FileType gitcommit,git setlocal foldmethod=syntax nolist nonumber norelativenumber
  au FileType gitcommit setlocal spell | wincmd K
  au FileType gitcommit nnoremap <silent> <buffer> U :call system("git checkout -- <C-r><C-g>")<CR>R
  au FileType gitcommit nnoremap <silent> <buffer> cA :<C-U>Gcommit --amend --date="$(date)"<CR>
  au BufReadPost fugitive://* set bufhidden=delete
  au User fugitive
        \  if fugitive#buffer().type() =~# '^\%(tree\|blob\)$'
        \|   nnoremap <buffer> .. :edit %:h<CR>
        \| endif
augroup END

" }}}}
" Magit {{{

nnoremap <silent> <leader>m :Magit<cr>

" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = 0
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.ruby = ['omni']

function! s:lazy_load() abort
  call deoplete#enable()
  augroup deoplete_loader
    au!
  augroup END
endfunction

augroup deoplete_loader
  au!
  au InsertEnter * call s:lazy_load()
augroup END

" }}}
" Neosnippet {{{

let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'

imap <expr> <tab> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

smap <expr> <tab> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

" }}}
" Anzu + Asterisk + is.vim {{{

let g:asterisk#keeppos = 1

map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)zz
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)zz

" }}}
" Ale {{{

let g:ale_linters = { 'eruby': [] }
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_lint_delay = 1000
let g:ale_set_highlights = 0

hi link ALEErrorSign ErrorMsg

nmap ]r <Plug>(ale_next_wrap)
nmap [r <Plug>(ale_previous_wrap)

" }}}
" CtrlSF {{{

let g:ctrlsf_case_sensitive = 'no'

nnoremap <leader>f :CtrlSF<Space>

" }}}
" Smartword {{{

nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
xmap w <Plug>(smartword-w)
xmap b <Plug>(smartword-b)
xmap e <Plug>(smartword-e)
xmap ge <Plug>(smartword-ge)

" }}}
" Startify {{{

let g:startify_change_to_vcs_root = 1

" }}}
" Emmet {{{

let g:user_emmet_mode = 'i'

augroup emmet
  au!
  au FileType sass,scss imap <buffer> <expr> <tab> emmet#isExpandable() ?
        \ "\<Plug>(emmet-expand-abbr)" : "\<tab>"
augroup END

" }}}
" Sort Motion {{{

let g:sort_motion_flags = "ui"

" }}}
" Pasted Text Object {{{

let g:pastedtext_select_key = "gp"

" }}}
" Sneak {{{

let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#target_labels = "asdfghjklqwertyuiopzxcvbnmASDFGHJKLQWERTYUIOPZXCVBNM"
let g:sneak#use_ic_scs = 1

nmap ç <Plug>Sneak_s
nmap Ç <Plug>Sneak_S
omap ç <Plug>Sneak_s
omap Ç <Plug>Sneak_S
xmap ç <Plug>Sneak_s
xmap Ç <Plug>Sneak_S

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" }}}
" Highlighted Yank {{{

let g:highlightedyank_highlight_duration = 200

" }}}
" Lexima {{{

let g:lexima_enable_endwise_rules = 0
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
call lexima#insmode#map_hook('before', '<CR>', '')

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . lexima#expand('<CR>', 'i')
endfunction

call lexima#add_rule({
      \ 'at': '\v\w+:\s+%#',
      \ 'char': '=',
      \ 'input': '<%=  %><Left><Left><Left>',
      \ 'filetype': 'eruby.yaml'
      \ })

" }}}
" Test {{{

nmap <silent> <leader>rr :TestNearest<CR>
nmap <silent> <leader>rf :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rg :TestVisit<CR>

let test#strategy = "vtr"

" }}}
" Sideways {{{

nnoremap <silent> sh :SidewaysLeft<cr>
nnoremap <silent> sl :SidewaysRight<cr>

omap <silent> aa <Plug>SidewaysArgumentTextobjA
xmap <silent> aa <Plug>SidewaysArgumentTextobjA
omap <silent> ia <Plug>SidewaysArgumentTextobjI
xmap <silent> ia <Plug>SidewaysArgumentTextobjI

" }}}

" }}}
