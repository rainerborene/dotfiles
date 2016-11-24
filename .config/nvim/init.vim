" .vimrc of Rainer Borene
" =======================
" Plugged {{{

" Disable default plugins
let g:loaded_netrwPlugin = 1
let g:loaded_vimballPlugin = "v35"
let g:loaded_getscriptPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_tar = 1
let g:loaded_zipPlugin = 1
let g:loaded_zip = 1

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'benekastah/neomake'
Plug 'chriskempson/base16-vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'felixjung/vim-base16-lightline'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-slash'
Plug 'kana/vim-niceblock'
Plug 'kana/vim-smartinput'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'rhysd/clever-f.vim'
Plug 'rhysd/vim-textobj-anyblock'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'sjl/clam.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-textobj-comment'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/tmux-complete.vim'

runtime! macros/matchit.vim
call plug#end()

" }}}
" Basic options {{{

set completeopt=longest,menuone
set confirm
set expandtab
set fillchars=diff:—,vert:│
set foldlevel=99
set formatoptions=qrn1j
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
set synmaxcol=120

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

let base16colorspace=256
set background=dark
colorscheme base16-twilight

hi VertSplit ctermbg=NONE guibg=NONE
hi ExtraWhitespace ctermbg=red guibg=red
hi Number ctermfg=14

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
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" Resize window
nnoremap <silent><Down>  5<C-w>-
nnoremap <silent><Up>    5<C-w>+
nnoremap <silent><Left>  5<C-w><
nnoremap <silent><Right> 5<C-w>>

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
nnoremap <expr> } foldclosed(search('^$', 'Wn'))  == -1 ? '}' : '}j}'
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? '{' : '{k{'

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Quit
inoremap <C-Q> <esc>:q<cr>
nnoremap <C-Q> :q<cr>
vnoremap <C-Q> <esc>

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

" Close quickfix/location window
nnoremap <leader>c :cclose<bar>lclose<cr>

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
cnoremap <C-g> <C-c>
cnoremap <c-@> <c-f>

" Send to the black hole register
noremap x "_x
noremap X "_X

" Replace currently selected text with default register without yanking it
vnoremap p "_dP

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

" Terminal mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <c-w>j <c-\><c-n><c-w>j
tnoremap <c-w>k <c-\><c-n><c-w>k
tnoremap <c-w>h <c-\><c-n><c-w>h
tnoremap <c-w>l <c-\><c-n><c-w>l
tnoremap <pageup> <c-\><c-n><pageup>
tnoremap <pagedown> <c-\><c-n><pagedown>

" }}}
" Autocommands {{{

augroup ft_postgres
  au!
  au BufNewFile,BufRead /tmp/sql*,*.sql,*psql* set filetype=pgsql
  au FileType pgsql set softtabstop=2 shiftwidth=2
  au FileType pgsql set foldmethod=indent
  au FileType pgsql setlocal commentstring=--\ %s comments=:--
augroup END

augroup ft_zsh
  au!
  au FileType zsh setlocal foldmethod=marker
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
  au FileType json setlocal formatprg=jq\ .
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

augroup ft_fuse
  au!
  au BufNewFile,BufRead *.ux setlocal filetype=xml
  au BufNewFile,BufRead *.unoproj setlocal filetype=json
augroup END

augroup ft_qf
  au!
  au FileType qf setlocal nowrap | wincmd J
  au FileType qf nnoremap <buffer> <silent> q :cclose<cr>
augroup END

augroup vimrc
  au!
  au FileType vim setlocal foldmethod=marker keywordprg=:help

  " File type detection
  au BufWritePost
        \ * if &l:filetype ==# '' || exists('b:ftdetect')
        \ |   unlet! b:ftdetect
        \ |   filetype detect
        \ | endif

  " Automatically opens the quickfix window after :Ggrep.
  au QuickFixCmdPost *grep* cwindow

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

" }}}
" HTML5 {{{

let g:html_indent_tags = 'li\|p'

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

augroup ft_nerdtree
  au!
  au FileType nerdtree setlocal colorcolumn& nowrap tw=0
augroup END

" Open NERDTree file explorer
nnoremap <leader>e :e <c-r>=expand('%:p:h') . '/'<cr><cr>

" }}}
" Switch {{{

let g:switch_mapping = "-"
let g:switch_javascript_definitions = [{
      \ '\[["'']\(\k\+\)["'']\]': '\.\1',
      \ '\.\(\k\+\)': '[''\1'']'
      \ }]

let g:switch_scss_definitions = [
      \ ['right', 'left']
      \ ]

let g:switch_ruby_definitions = [
      \ ['has_key?', 'key?']
      \ ]

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

let $FZF_DEFAULT_OPTS .= ' --inline-info'

let g:fzf_layout = { 'down': '20%' }

function! s:fzf_statusline()
  highlight fzf1 ctermfg=12 ctermbg=NONE
  highlight fzf2 ctermfg=8 ctermbg=NONE
  highlight fzf3 ctermfg=8 ctermbg=NONE
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

augroup ft_fzf
  au!
  au FileType fzf nnoremap <silent> <buffer> <c-g> :q<cr>
  au User FzfStatusLine call s:fzf_statusline()
  au VimEnter * command! -nargs=+ -complete=file Ag
        \ call fzf#vim#ag_raw('--hidden ' . <q-args>)
augroup END

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>. :Tags<CR>
vnoremap <leader>a "zy:execute "Ag " . @z<cr>
nnoremap <leader>a :Ag<Space>

" }}}
" Rails {{{

let g:rails_abbreviations = {
      \ "it": "it { ",
      \ "ivp": "is_expected.to validate_presence_of :",
      \ "pry": "binding.pry"
      \ }

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
" Neomake {{{

let g:neomake_verbose = 0

function! s:lint()
  let has_linters = executable('eslint') || executable('xo')
  if &filetype =~ 'javascript' && has_linters
    exe 'Neomake ' len(glob('.eslint*')) ? 'eslint' : 'xo'
  else
    Neomake
  end
endfunction

augroup Neomake
  au!
  au BufWritePost * call <sid>lint()
augroup END

" }}}
" EasyAlign {{{

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)

" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.ruby = ['omni']

function g:Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction

function g:Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction

" }}}
" Neosnippet {{{

let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'

imap <C-@> <Plug>(neosnippet_expand_or_jump)
smap <C-@> <Plug>(neosnippet_expand_or_jump)
xmap <C-@> <Plug>(neosnippet_expand_target)

" }}}
" Goyo {{{

augroup Goyo
  au!
  au User GoyoEnter Limelight
  au User GoyoLeave Limelight!
augroup END

" }}}
" Emmet {{{

let g:user_emmet_expandabbr_key = '<C-_>'
" let g:user_emmet_prev_key = '<C-[>'
" let g:user_emmet_next_key = '<C-]>'
let g:user_emmet_settings = {
      \ 'javascript' : {
      \   'extends' : 'jsx'
      \ }}

" }}}
" Slash {{{

" zz after search
noremap <plug>(slash-after) zz

" }}}
" Tmux {{{

function! s:tmux_load_buffer()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  let tempfile = tempname()
  call writefile(lines, tempfile, 'a')
  call system('tmux load-buffer '.tempfile)
  call delete(tempfile)
endfunction
vnoremap <silent> <leader>y :call <sid>tmux_load_buffer()<cr>
nnoremap <silent> <leader>y :Tyank<cr>
nnoremap <silent> <leader>p :Tput<cr>

" }}}
" Clam {{{

nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>
let g:clam_autoreturn = 1
let g:clam_debug = 1

" }}}
" Lightline {{{

let g:lightline = {
      \ 'colorscheme': 'base16_twilight',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['fugitive', 'filename', 'modified']]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" }}}

" }}}
