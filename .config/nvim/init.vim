" init.vim of Rainer Borene
" =======================
" Plugged {{{

" Disable default plugins
let g:loaded_matchit = 1
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
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'andersevenrud/compe-tmux', { 'branch': 'cmp' }
Plug 'andymass/vim-matchup'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'cocopon/shadeline.vim'
Plug 'folke/tokyonight.nvim'
Plug 'glts/vim-textobj-comment'
Plug 'haya14busa/vim-asterisk'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'janko-m/vim-test'
Plug 'kana/vim-niceblock'
Plug 'kana/vim-smartword'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-textobj-delimited'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'onsails/lspkind-nvim'
Plug 'quangnguyen30192/cmp-nvim-tags'
Plug 'rafamadriz/friendly-snippets'
Plug 'rhysd/clever-f.vim'
Plug 'rhysd/vim-textobj-word-column'
Plug 'romainl/vim-cool'
Plug 'roxma/vim-tmux-clipboard'
Plug 'saaguero/vim-textobj-pastedtext'
Plug 'sheerun/vim-polyglot'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'svermeulen/vim-subversive'
Plug 'tamago324/lir.nvim'
Plug 'thinca/vim-quickrun'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'whatyouhide/vim-textobj-erb'
Plug 'whiteinge/diffconflicts'
Plug 'windwp/nvim-autopairs'

call plug#end()

lua require('impatient')

" }}}
" Basic options {{{

" misc
set confirm
set lazyredraw
set shortmess+=c
set noswapfile
set nowritebackup
set spellfile=~/.config/nvim/spell/custom-dictionary.utf-8.add
set spelllang=pt,en
set undofile
set undoreload=10000
set notimeout
set ttimeout
set ttimeoutlen=0
set updatetime=1000

" text manipulation
set expandtab
set formatoptions=qrn1j
set linebreak
set shiftwidth=2
set tabstop=4
set textwidth=80
set virtualedit+=block
set completeopt=noinsert,menuone,noselect

" better navigation
set foldlevel=99
set gdefault
set ignorecase
set smartcase
set splitbelow
set splitright
set sidescroll=1
set nostartofline

" wild stuff
set wildmode=list:longest,full
set wildignore+=*.DS_Store
set wildignore+=*~,.git,*.pyc,*.o,*.spl,*.rdb
set wildignore+=.sass-cache

" ui customization
set list
set diffopt+=algorithm:patience
set listchars=tab:»\ ,trail:·,extends:❯,precedes:❮
set fillchars=diff:─,vert:│,msgsep:─
set showbreak=↪\ "
set noshowmode
set relativenumber
set number
set conceallevel=2
set concealcursor=niv
set pumheight=20
set laststatus=3

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f\ %l%m
endif

" }}}
" Color scheme {{{

set background=dark
set termguicolors

function! init#colorscheme() abort
  hi! MatchWord gui=bold
  hi! GitSignsDelete guifg=#FF9580
endfunction

augroup vimrc_colorscheme
  au!
  au ColorScheme * call init#colorscheme()
augroup END

let g:tokyonight_style = "night"
colorscheme tokyonight

" }}}
" Mappings {{{

let mapleader = ","
let maplocalleader = "\\"

" Easy command-line mode
map ; :

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
function! s:redraw()
  nohlsearch
  lua vim.lsp.diagnostic.redraw()
  lua require'cmp'.close()
  normal! zx
  redraw!
  echo
endfunction
nnoremap U :call <sid>redraw()<cr>

" Useful mappings for managing tabs
nnoremap          <leader>te <esc>:tabedit<Space>
nnoremap <silent> <leader>tn <esc>:tabnew<cr>
nnoremap <silent> <leader>to <esc>:tabonly<cr>
nnoremap <silent> <leader>td <esc>:tabclose<cr>
nnoremap          <leader>tm <esc>:tabmove<Space>
nnoremap <silent> <leader>tb <esc>:tab ball<cr>
nnoremap <silent> <leader>tl <esc>:tabs<cr>

" [w ]w - Forward and backwards tabs
nnoremap <silent> [w <esc>:tabprevious<cr>
nnoremap <silent> ]w <esc>:tabnext<cr>

" [W ]W - Move tabs
nnoremap <silent> [W <esc>:tabmove -1<cr>
nnoremap <silent> ]W <esc>:tabmove +1<cr>

" ,[1-9] - Switch to tab #
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" ,t(g)t - Open tag in tab
nnoremap <silent> <leader>tt  <esc>:tab split<cr>:exe("tag ".expand("<cword>"))<cr>
nnoremap <silent> <leader>tgt <esc>:tab split<cr>:exe("tjump ".expand("<cword>"))<cr>

" Split windows
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" Faster scrolling
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

" Resize window
nnoremap <left>  <c-w>>
nnoremap <right> <c-w><
nnoremap <up>    <c-w>-
nnoremap <down>  <c-w>+

" Sane movement with wrap turned on
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
vnoremap j gj
vnoremap k gk

" { and } skip over closed folds instead of openning them
nnoremap <expr> } foldclosed(search('^$', 'Wn'))  == -1 ? '}zz' : '}j}zz'
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? '{zz' : '{k{zz'

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" No overwrite paste
xnoremap p "_dP

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" Focus the current fold by folding all the others
nnoremap <leader>z zMzvzz

" Ctrl-g: Prints current file name
nnoremap <c-g> 2<c-g>

" Ctrl-b: Go (b)ack. Go to previously buffer
nnoremap <c-b> <c-^>

" Quit
inoremap <silent> <C-Q> <esc>:q<cr>
nnoremap <silent> <C-Q> :q<cr>

" Save
inoremap <silent> <C-s> <C-o>:update<cr>
nnoremap <silent> <C-s> :update<cr>

" Command-line abbreviations
cnoreabbrev Wqa wqa
cnoreabbrev W w

" Send to the black hole register
noremap x "_x
noremap X "_X
noremap _ "_d

" Goto older/newer position in change list
nnoremap <silent> ( g;zvzz
nnoremap <silent> ) g,zvzz

" Clean trailing whitespace
nnoremap <silent> =w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

" Fast access to some registers
noremap! <c-r>/ <c-r>=substitute(getreg('/'), '[<>\\]', '', 'g')<cr>
noremap! <c-r>w <c-r>=expand("<cword>")<cr>

" Change current word and prepare to repeat next occurence (like *cgn)
nnoremap c* :<C-U>let @/='\<'.expand("<cword>").'\>'<CR>:set hlsearch<CR>cgn

" Goto line/column instead
noremap ' `

" Mark position before search
nnoremap / ms/

" Replace alias
nnoremap s/ mr:%s/

" inVerse search: line NOT containing pattern
cnoremap <m-/> \v^(()@!.)*$<Left><Left><Left><Left><Left><Left><Left>

" Easier dir/file manipulation
nnoremap <leader>e :e <c-r>=expand('%:p:h') . '/'<cr><cr>
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'
cnoremap <expr> %< getcmdtype() == ':' ? fnameescape(expand('%:t')) : '%<'

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

" Open notes directory
nnoremap <silent> <leader>n <esc>:tabedit ~/Dropbox/Notebook/Notes<cr>

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
  au FileType ruby setlocal foldmethod=expr
  au FileType ruby setlocal foldexpr=nvim_treesitter#foldexpr()
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

  " Resize splits when the window is resized
  au VimResized * :wincmd =

  " No folds closed when editing new files
  au BufNew * setlocal foldlevelstart=99

  " Don't keep undo files in temp directories or shm
  au BufWritePre /tmp/* setlocal noundofile

  " Don't keep viminfo for files in temp directories or shm
  au BufNewFile,BufReadPre /tmp/* setlocal viminfo=

  " Always show sign column
  au BufEnter *
        \  if !exists("b:signed_column") && filereadable(expand("%")) && &modifiable && &ft !~ "git"
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

  " Setup default omnifunc
  au FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
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
" Terminal {{{

tnoremap <Esc> <C-\><C-n>
tnoremap <a-a> <esc>a
tnoremap <a-b> <esc>b
tnoremap <a-d> <esc>d
tnoremap <a-f> <esc>f

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
" Open NPM package in a new tab {{{

function! s:nodejs_packages(A, L, P)
  return map(split(globpath("node_modules", a:A . "*"), "\n"), 'v:val[strlen("node_modules/"): -1]')
endfunction

function! s:nodejs_topen(package)
  let l:path = 'node_modules/'.a:package
  if filewritable(l:path) == 2
    silent exe 'tabedit '.l:path
    silent exe 'tcd '.l:path
  end
endf

command! -nargs=1 -complete=customlist,<sid>nodejs_packages Nopen call <sid>nodejs_topen(<q-args>)

" }}}
" Plugins {{{

" Ruby {{{

let g:no_ruby_maps = 1

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
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

nnoremap <silent> <leader>u :UndotreeToggle<CR>

" }}}
" Telescope {{{

lua require('rainer.telescope')

" Find files using Telescope command-line sugar.
nnoremap <leader><Leader> :Telescope find_files<cr>
nnoremap <leader><tab> :Telescope keymaps<cr>
nnoremap <leader>k :Telescope help_tags<cr>
nnoremap <leader>b :Telescope buffers<cr>
nnoremap <leader>a :Telescope live_grep<cr>
nnoremap <leader>A :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>f :lua require('telescope.builtin').grep_string { search = vim.fn.input("Grep For > "), use_regex = true }<cr>
nnoremap <leader>F :lua require('rainer.telescope').bundle_grep_string()<cr>
nnoremap <leader>' :Telescope marks<cr>
nnoremap <leader>. :Telescope tags<cr>

" }}}
" Fugitive {{{

nnoremap <silent> <leader>gd :Gvdiffsplit<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gl :Gclog<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>
nmap <silent> <leader>gs :Git<cr>gg)

augroup ft_git
  au!
  au FileType gitrebase nnoremap <buffer> <silent> S :Cycle<cr>
  au FileType gitcommit,git setlocal foldmethod=syntax nolist nonumber norelativenumber
  au FileType gitcommit setlocal spell
  au FileType fugitive,git nnoremap <buffer> <silent> q :q<cr>
  au BufReadPost fugitive://* set bufhidden=delete
augroup END

" }}}}
" Ale {{{

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_set_highlights = 0
let g:ale_ruby_rubocop_auto_correct_all = 1
let g:ale_fixers = {
      \ 'ruby': ['rubocop'],
      \ 'html': ['prettier'],
      \ 'json': ['jq'],
      \ 'javascript': ['prettier'],
      \ 'xml': ['xmllint']
      \ }

let g:ale_linters = {
      \ 'ruby': ['ruby', 'rubocop'],
      \ 'json': ['jq'],
      \ 'eruby': []
      \ }

hi link ALEErrorSign ErrorMsg
hi ALEErrorSign guibg=NONE

nmap <silent> [s <Plug>(ale_previous_wrap)
nmap <silent> ]s <Plug>(ale_next_wrap)

" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)

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
let g:startify_session_persistence = 1

" }}}
" Pasted Text Object {{{

let g:pastedtext_select_key = "gp"

" }}}
" Highlighted Yank {{{

augroup lua_highlight
  au!
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" }}}
" LSP {{{

lua require'lspconfig'.solargraph.setup{}
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.gopls.setup{}

nnoremap <silent> <leader>ld :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>li :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>ls :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>le :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>lr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>lh :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>la :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ll :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" }}}
" Compe {{{

lua require('rainer.cmp')

" }}}
" Vsnip {{{

let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')

" }}}
" Test {{{

let test#strategy = "vtr"

nmap <silent> <leader>rr :TestNearest<CR>
nmap <silent> <leader>rf :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rg :TestVisit<CR>
nmap <localleader>s :%VtrSendLinesToRunner<cr>
vmap <localleader>s :VtrSendLinesToRunner<cr>

" }}}
" Sideways {{{

nnoremap <silent> sh :SidewaysLeft<cr>
nnoremap <silent> sl :SidewaysRight<cr>

omap <silent> aa <Plug>SidewaysArgumentTextobjA
xmap <silent> aa <Plug>SidewaysArgumentTextobjA
omap <silent> ia <Plug>SidewaysArgumentTextobjI
xmap <silent> ia <Plug>SidewaysArgumentTextobjI

" }}}
" Clever-f {{{

let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1

" }}}
" QuickRun {{{

map ! <Plug>(quickrun)

" }}}
" Subversive {{{

nmap gr <plug>(SubversiveSubstitute)
nmap grr <plug>(SubversiveSubstituteLine)
nmap grl <plug>(SubversiveSubstituteToEndOfLine)

nmap <leader>gr <plug>(SubversiveSubstituteRange)
xmap <leader>gr <plug>(SubversiveSubstituteRange)
nmap <leader>grw <plug>(SubversiveSubstituteWordRange)

" }}}
" Asterisk {{{

let g:asterisk#keeppos = 1

map *  <Plug>(asterisk-z*)
map g* <Plug>(asterisk-gz*)
map #  <Plug>(asterisk-z#)
map g# <Plug>(asterisk-gz#)

" }}}
" Cool {{{

let g:CoolTotalMatches = 1

" }}}
" Shadeline {{{

function! WrapFugitiveHead()
  let name = exists('*FugitiveHead') ? FugitiveHead() : ''
  return empty(name) ? '' : printf('(%s)', name)
endfunction

let g:shadeline = {}
let g:shadeline.active = {
      \ 'left':  ['fname', 'WrapFugitiveHead', 'flags'],
      \ 'right': [
      \   ['ff', 'fenc', 'ft'],
      \   'ruler'
      \ ],
      \ }

let g:shadeline.inactive = {
      \ 'left': ['fname', 'flags'],
      \ }

" }}}
" Lir {{{

lua require('rainer.lir')

" }}}
" Gitsigns {{{

lua require('rainer.gitsigns')

" }}}
" Tmux {{{

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" }}}
" Treesitter {{{

lua require('rainer.treesitter')

" }}}
" Matchup {{{

let g:matchup_matchparen_offscreen = {}

" }}}

" }}}
