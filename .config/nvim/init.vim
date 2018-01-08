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

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'bfredl/nvim-miniyank'
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'jreybert/vimagit', { 'on': 'Magit' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(LiveEasyAlign)' }
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'kana/vim-niceblock'
Plug 'kana/vim-smartinput'
Plug 'kana/vim-smartword'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'kassio/neoterm'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-textobj-delimited'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'mhinz/vim-startify'
Plug 'rhysd/clever-f.vim'
Plug 'rhysd/vim-textobj-word-column'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'terryma/vim-multiple-cursors'
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
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'

call plug#end()

" }}}
" Basic options {{{

set completeopt=longest,menuone
set confirm
set expandtab
set fillchars=diff:—,vert:│
set foldlevel=99
set formatoptions=qrn1j
set inccommand=nosplit
set gdefault
set hidden
set ignorecase
set lazyredraw
set visualbell
set linebreak
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set noshowmode
set noswapfile
set nowritebackup
set shiftwidth=2
set shortmess=aoOtI
set showbreak=↪
set showcmd
set smartcase
set spellfile=~/.config/nvim/spell/custom-dictionary.utf-8.add
set spelllang=pt,en
set splitbelow
set splitright
set tabstop=4
set textwidth=80
set undofile
set undoreload=10000
set virtualedit+=block
set notimeout
set ttimeout
set ttimeoutlen=0

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
let g:quantum_black = 1

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set background=dark
set termguicolors

function! s:extend_colorscheme() abort
  hi! ExtraWhitespace ctermbg=red guibg=red
  hi! EndOfBuffer guibg=bg guifg=bg
endfunction

augroup vimrc_colorscheme
  au!
  au! ColorScheme quantum call s:extend_colorscheme()
augroup END

colorscheme quantum

" }}}
" Wilmenu completion {{{

set wildmode=list:longest,full
set wildignore+=*.DS_Store
set wildignore+=*~,.git,*.pyc,*.o,*.spl,*.rdb
set wildignore+=.sass-cache

" }}}
" Mappings {{{

let mapleader = ","
let maplocalleader = "\\"

" Easier bracket matching
map <Tab> %
map <C-o> <nop>
silent! unmap [%
silent! unmap ]%

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

" @: repeats macro on every line
xnoremap @ :normal@

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Move to last change
nnoremap gI `.zz

" Reselect last selection
xnoremap <  <gv
xnoremap >  >gv

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z

" I hate when the rendering occasionally gets messed up.
nnoremap <silent> U :syntax sync fromstart<cr>:redraw!<cr>

" Sort lines
nmap gs vii:!sort<cr>
vmap gs :!sort<cr>

" Speed up window switching
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
inoremap <C-l> <C-o><C-w>l

" Resize window
nnoremap <left>   <c-w>>
nnoremap <right>  <c-w><
nnoremap <up>     <c-w>-
nnoremap <down>   <c-w>+

" Fast tab switching
nnoremap gn :<C-u>tabnew<CR>
nnoremap ge :<C-u>tabedit<Space>
nnoremap gx :<C-u>tabclose<CR>
nnoremap <silent><A-h> gT
nnoremap <silent><A-l> gt

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
inoremap <C-Q> <esc>:Sayonara<cr>
nnoremap <C-Q> :Sayonara<cr>

" Save
inoremap <C-s> <C-o>:update<cr>
nnoremap <C-s> :update<cr>

" Select just-pasted text
nnoremap gV `[v`]

" Make Y consistent with C and D.
nnoremap Y y$

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" Focus the current fold by folding all the others
nnoremap <leader>z zMzvzz

" Source
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

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
cnoremap <c-k> <up>
cnoremap <c-j> <down>
cnoremap <c-g> <C-c>
cnoremap <c-@> <C-f>

" Send to the black hole register
noremap x "_x
noremap X "_X

" Do not override the register after paste in select mode
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" Goto older/newer position in change list
nnoremap <silent> ( g;zvzz
nnoremap <silent> ) g,zvzz

" Rebuild Ctags
nnoremap <silent> g<cr> :!ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Clean trailing whitespace
nnoremap <silent> =w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

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
" Terminal mode {{{

let g:neoterm_position = 'vertical'

function! s:terminit()
  nnoremap <buffer> I I<C-a>
  nnoremap <buffer> A A<C-e>
  nnoremap <buffer> C i<C-k>
  nnoremap <buffer> D i<C-k><C-\><C-n>
  nnoremap <buffer> cc i<C-e><C-u>
  nnoremap <buffer> dd i<C-e><C-u><C-\><C-n>

  if match(b:term_title, 'fzf') > -1
    tmap <buffer> <c-j> <c-j>
    tmap <buffer> <c-k> <c-k>
    tmap <buffer> <c-l> <c-l>
    tmap <buffer> <c-h> <c-h>
  endif
endfunction

function! s:move(dir)
  let previous = bufnr('%')
  let fallback = {
        \ 'h': "\<C-h>",
        \ 'j': "\<C-j>",
        \ 'k': "\<C-k>",
        \ 'l': "\<C-l>"
        \ }
  exec 'wincmd '.a:dir
  if bufnr('%') == previous && exists('b:terminal_job_id')
    call jobsend(b:terminal_job_id, get(fallback, a:dir))
    startinsert
  endif
endfunction

au TermOpen * call s:terminit()
au BufEnter term://* startinsert

tnoremap <Esc> <C-\><C-n>
tnoremap <c-q> <c-\><c-n>:Sayonara<cr>
tnoremap <pageup> <c-\><c-n><pageup>
tnoremap <pagedown> <c-\><c-n><pagedown>

tnoremap <silent> <c-j> <c-\><c-n>:call <sid>move('j')<cr>
tnoremap <silent> <c-k> <c-\><c-n>:call <sid>move('k')<cr>
tnoremap <silent> <c-h> <c-\><c-n>:call <sid>move('h')<cr>
tnoremap <silent> <c-l> <c-\><c-n>:call <sid>move('l')<cr>

" moving between chars and words
tnoremap <A-a> <esc>a
tnoremap <A-b> <esc>b
tnoremap <A-d> <esc>d
tnoremap <A-f> <esc>f

nnoremap <silent> <C-c><C-c> :TREPLSendFile<cr>
nnoremap <silent> <C-c><C-l> :call neoterm#clear()<cr>
nnoremap <silent> <C-c><C-k> :call neoterm#kill()<cr>
nnoremap <silent> <C-c><C-j> :call neoterm#toggle()<cr>

nnoremap <silent> <leader>s :botright new<bar>term<cr>:startinsert<cr>
nnoremap <silent> <leader>v :vertical botright split<bar>term<cr>:startinsert<cr>
nnoremap <silent> <leader>r :T bin/rails test %<cr>

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
  nnoremap <buffer><silent> q :<C-u>cclose<CR>
  nnoremap <buffer><silent> j :<C-u>cnext<CR>:copen<CR>
  nnoremap <buffer><silent> k :<C-u>cprevious<CR>:copen<CR>
  nnoremap <buffer><silent> J :<C-u>cnfile<CR>:copen<CR>
  nnoremap <buffer><silent> K :<C-u>cpfile<CR>:copen<CR>
  nnoremap <buffer><silent> l :<C-u>clist<CR>
endfunction

augroup ft_qf
  au!
  au FileType qf setlocal nowrap | wincmd J
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

augroup ft_coffee
  au!
  au BufNewFile,BufRead *.coffee set filetype=coffee
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

augroup ft_c
  au!
  au FileType c setlocal noet shiftwidth=8 tabstop=8
augroup END

augroup ft_css
  au!
  au FileType css,scss setlocal foldmethod=marker foldmarker={,}
  au FileType css,scss,sass setlocal iskeyword+=-
augroup END

augroup ft_ruby
  au!
  au BufRead *gemrc setlocal filetype=yaml
  au FileType ruby setlocal foldmethod=syntax
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
  au BufWritePost
        \ * if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

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

  " Restore cursor position
  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au VimLeave * call system('tmux set-window automatic-rename on')
    au BufEnter *
          \ if empty(&buftype) |
          \   call system('tmux rename-window '.expand('%:t:S')) |
          \ endif
  endif
augroup END

" }}}
" Help in new tabs {{{

function! s:helptab()
  if &buftype == 'help'
    wincmd T
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
let g:ruby_space_errors = 1
let g:ruby_fold = 1
let g:ruby_no_expensive = 1
let g:ruby_spellcheck_strings = 1

" }}}
" NERDTree {{{

let g:NERDTreeHijackNetrw = 1
let g:NERDTreeIgnore = ['\.DS_Store$']
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
let g:switch_scss_definitions = [['right', 'left']]
let g:switch_ruby_definitions = [['has_key?', 'key?']]
let g:switch_javascript_definitions = [{
      \ '\[["'']\(\k\+\)["'']\]': '\.\1',
      \ '\.\(\k\+\)': '[''\1'']'
      \ }]

function! s:load_switch_definitions()
  silent! let b:switch_custom_definitions = g:switch_{&filetype}_definitions
endfunction

augroup Switch
  au!
  au BufEnter * call s:load_switch_definitions()
augroup END

" }}}
" Undotree {{{

let g:undotree_WindowLayout = 2

nnoremap <silent> <leader>u :UndotreeToggle<CR>

" }}}
" FZF {{{

function! s:fzf_remove(lines)
  for line in a:lines
    if input('Delete '. line .'? [y/n]: ') == 'y'
      call delete(line)
    endif
  endfor
endfunction

let $FZF_DEFAULT_OPTS .= ' --inline-info'

let g:fzf_layout = { 'down': '20%' }
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'del': function('s:fzf_remove')
      \ }

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
      \ 'header': ['fg', 'Comment']
      \ }

augroup ft_fzf
  au!
  au FileType fzf nnoremap <silent> <buffer> <c-g> :q<cr>

  " Hide statusline of terminal buffer
  au FileType fzf set laststatus=0 | au BufLeave <buffer> set laststatus=2
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
nnoremap <silent> <Leader>. :Tags<CR>
vnoremap <leader>a "zy:execute "Rg " . @z<cr>
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
  au FileType gitcommit,git setlocal foldmethod=syntax colorcolumn& nolist
  au FileType gitcommit setlocal spell | wincmd K
  au FileType gitcommit nnoremap <silent> <buffer> U :call system("git checkout -- <C-r><C-g>")<CR>R
  au FileType gitcommit nnoremap <silent> <buffer> cA :<C-U>Gcommit --amend --date="$(date)"<CR>
  au BufReadPost fugitive://* set bufhidden=delete
  au User fugitive
        \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
        \   nnoremap <buffer> .. :edit %:h<CR> |
        \ endif
augroup END

" }}}}
" Magit {{{

nnoremap <silent> <leader>m :Magit<cr>

" }}}
" EasyAlign {{{

" Start interactive EasyAlign in visual mode
xmap <cr> <plug>(LiveEasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(LiveEasyAlign)

" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = 0
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.ruby = ['omni']

augroup deoplete_loader
  au!
  au InsertEnter * call deoplete#enable()
augroup END

function! g:Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
  ALEDisable
endfunction

function! g:Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
  ALEEnable
endfunction

" }}}
" Neosnippet {{{

let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'

imap <C-Space> <Plug>(neosnippet_expand_or_jump)
smap <C-Space> <Plug>(neosnippet_expand_or_jump)
xmap <C-Space> <Plug>(neosnippet_expand_target)

" }}}
" Slash {{{

" zz after search
noremap <plug>(slash-after) zz

" }}}
" Lightline {{{

let g:lightline = {
      \ 'colorscheme': 'quantum',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['fugitive', 'filename', 'modified']]
      \ },
      \ 'component_function': {
      \   'fugitive': 'fugitive#head'
      \ }
      \ }

" }}}
" Peekaboo {{{

let g:peekaboo_window = 'vert bo 50new'

" }}}
" Ale {{{

let g:ale_linters = { 'eruby': [] }
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_lint_delay = 1000

nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)

" }}}
" Clever-f {{{

let g:clever_f_smart_case = 1
let g:clever_f_across_no_line = 1

" }}}
" EasyMotion {{{

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap m <Plug>(easymotion-overwin-f2)
vmap m <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)

" hjkl
map ;h <Plug>(easymotion-linebackward)
map ;j <Plug>(easymotion-j)
map ;k <Plug>(easymotion-k)
map ;l <Plug>(easymotion-lineforward)

" goto
map go <Plug>(easymotion-overwin-f2)

" }}}
" CtrlSF {{{

let g:ctrlsf_case_sensitive = 'no'

nnoremap <leader>f :CtrlSF<Space>
vnoremap <silent> <leader>f "zy:execute "CtrlSF " . @z<cr>

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
" Smartinput {{{

call smartinput#map_to_trigger('i', '=', '=', '=')
call smartinput#define_rule({
      \ 'at': '\v\w+:\s+%#',
      \ 'char': '=',
      \ 'input': '<%=  %><Left><Left><Left>',
      \ 'filetype': ['eruby.yaml']
      \ })

call smartinput#map_to_trigger('i', '#', '#', '#')
call smartinput#define_rule({
      \ 'at': '\%#',
      \ 'char': '#',
      \ 'input': '#{}<Left>',
      \ 'filetype': ['ruby', 'coffee'],
      \ 'syntax': ['String']
      \ })

" }}}
" Highlightedyank {{{

let g:highlightedyank_highlight_duration = 500

hi HighlightedyankRegion ctermfg=2 ctermbg=10 guifg=#8f9d6a guibg=#323537

" }}}
" Startify {{{

let g:startify_change_to_vcs_root = 1

" }}}
" Sayonara {{{

let g:sayonara_confirm_quit = 0

" }}}

" }}}
