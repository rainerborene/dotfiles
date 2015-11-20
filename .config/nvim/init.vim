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

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/switch.vim'
Plug 'benekastah/neomake', { 'on': ['Neomake'] }
Plug 'chriskempson/base16-vim'
Plug 'cohama/lexima.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-after-object'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-pseudocl'
Plug 'kana/vim-niceblock'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'kassio/neoterm'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'osyo-manga/vim-over'
Plug 'osyo-manga/vim-textobj-multiblock'
Plug 'PeterRincker/vim-argumentative'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-textobj-comment'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

runtime! macros/matchit.vim
call plug#end()

" }}}
" Basic options {{{

set colorcolumn=+1
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

" }}}
" Statusline {{{

set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

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

set background=dark
colorscheme base16-twilight

hi VertSplit ctermbg=NONE guibg=NONE
hi ExtraWhitespace ctermbg=red guibg=red

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

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Move to last change
nnoremap gI `.

" Clean trailing whitespace
nnoremap <silent> =w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z

" I hate when the rendering occasionally gets messed up.
nnoremap <silent> U :syntax sync fromstart<cr>:redraw!<cr>

" Sort lines
nnoremap gs vip:!sort<cr>
vnoremap gs :!sort<cr>

" Speed up window switching
nnoremap <BS> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" Map m-] to be the inverse of c-]
nnoremap <m-]> <c-t>

" Fast tab switching
nnoremap <C-t> :tabnew<cr>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt

" Sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Kill window
nnoremap K :q<cr>

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

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-k> <up>
cnoremap <c-j> <down>
cnoremap <C-g> <C-c>

" Send to the black hole register
noremap x "_x
noremap X "_X

" Preserve previous paste
vnoremap p pgvy

" Save
inoremap <C-s> <C-o>:update<cr>
nnoremap <C-s> :update<cr>

" Paste clipboard selection
nnoremap <silent> <leader>p :r!xclip -selection clipbard -o<cr>

" Rebuild Ctags
nnoremap <silent> g<cr> :!ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Easy filetype switching
nnoremap =f :setfiletype<Space>

" Insert Mode Completion
imap <c-]> <c-x><c-]>
imap <c-@> <c-x><c-o>
imap <c-j> <c-n>
imap <c-k> <c-p>

" Terminal controlling
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

augroup ft_javascript
  au!
  au BufNewFile,BufRead .jshintrc,*.es6 set filetype=javascript
  au FileType javascript setlocal foldmethod=marker foldmarker={,}
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

augroup ft_i3
  au!
  au BufRead,BufNewFile *i3/config setlocal ft=i3 commentstring=#\ %s
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

augroup ft_qf
  au!
  au FileType qf setlocal nowrap | wincmd J | nnoremap <buffer> q :q<cr>
augroup END

augroup vimrc
  au!
  au FileType vim setlocal foldmethod=marker

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

  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  au InsertEnter *
        \ if !exists('w:last_fdm') |
        \   let w:last_fdm=&foldmethod |
        \   setlocal foldmethod=manual |
        \ endif

  au InsertLeave,WinLeave *
        \ if exists('w:last_fdm') |
        \   let &l:foldmethod=w:last_fdm |
        \   unlet w:last_fdm |
        \ endif

  " Restore cursor position
  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" }}}
" Grep {{{

if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
command -nargs=+ -complete=file -bar Grep silent! grep! <args> | cwindow | redraw!

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
" Quickfix niceties {{{

function! QuickFixDo(cmd)
  let bufnam = {}
  for q in getqflist()
    let bufnam[q.bufnr] = bufname(q.bufnr)
  endfor
  for n in keys(bufnam)
    exe 'buffer' n
    exe a:cmd
    update
  endfor
endfunction
command! -nargs=+ Qfixdo call QuickFixDo(<q-args>)

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
" Surround {{{

let g:surround_no_insert_mappings = 1

" }}}
" NERDTree {{{

let g:NERDTreeHijackNetrw = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapJumpNextSibling = 'gj'
let g:NERDTreeMapJumpPrevSibling = 'gk'
let g:NERDTreeMapJumpFirstChild = 'gK'

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

let g:fzf_layout = { 'down': '10%' }

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
augroup END

nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>. :Tags<CR>
vnoremap <leader>a "zy:execute "Ag " . @z<cr>
nnoremap <leader>a :Ag<Space>

imap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
imap <c-x><c-j> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

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
  au FileType git,gitcommit setlocal foldmethod=syntax colorcolumn& nolist
  au FileType gitcommit nmap <silent> <buffer> U :call system("git checkout -- <C-r><C-g>")<CR>R
  au FileType gitcommit setlocal spell | wincmd K
  au BufReadPost fugitive://* set bufhidden=delete
  au User fugitive
        \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
        \   nnoremap <buffer> .. :edit %:h<CR> |
        \ endif
augroup END

" }}}}
" Neoterm {{{

let g:neoterm_size = 15

" Run tests
vnoremap <silent> <f6> :TREPLSend<cr>
nnoremap <silent> <f6> :TREPLSendFile<cr>
nnoremap <silent> <f8> :call neoterm#test#run('all')<cr>
nnoremap <silent> <f9> :call neoterm#test#run('file')<cr>
nnoremap <silent> <f10> :call neoterm#test#run('current')<cr>
nnoremap <silent> <f11> :call neoterm#test#rerun()<cr>

nnoremap <silent> <leader>to :Topen<cr>
nnoremap <silent> <leader>tc :Tclose<cr>
nnoremap <silent> <leader>tl :call neoterm#clear()<cr>
nnoremap <silent> <leader>tk :call neoterm#kill()<cr>

" }}}
" Neomake {{{

let g:neomake_verbose = 0

augroup Neomake
  au!
  au BufWritePost * Neomake
augroup END

" }}}
" Oblique {{{

augroup Oblique
  au!
  au User Oblique       normal! zz
  au User ObliqueStar   normal! zz
  au User ObliqueRepeat normal! zz
augroup END

" }}}
" Text Objects {{{

omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)

augroup AfterObject
  au!
  au VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
augroup END

" }}}
" EasyAlign {{{

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)

" }}}
" Over {{{

nnoremap g/ ms:<c-u>OverCommandLine<cr>%s/\v
xnoremap g/ ms:<c-u>OverCommandLine<cr>%s/\%V\v

" }}}

" }}}
