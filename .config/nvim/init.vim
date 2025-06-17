" init.vim of Rainer Borene
" =========================
" Plugged {{{

lua vim.loader.enable()

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
Plug 'MagicDuck/grug-far.nvim'
Plug 'Saghen/blink.cmp', { 'do': 'cargo build --release' }
Plug 'andymass/vim-matchup'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'cocopon/shadeline.vim'
Plug 'echasnovski/mini.align'
Plug 'echasnovski/mini.operators'
Plug 'folke/snacks.nvim'
Plug 'folke/ts-comments.nvim'
Plug 'haya14busa/vim-asterisk'
Plug 'janko-m/vim-test'
Plug 'junegunn/gv.vim'
Plug 'kana/vim-niceblock'
Plug 'kana/vim-smartword'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'kylechui/nvim-surround'
Plug 'lewis6991/gitsigns.nvim'
Plug 'machakann/vim-textobj-delimited'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mfussenegger/nvim-lint'
Plug 'mhinz/vim-startify'
Plug 'mikavilpas/blink-ripgrep.nvim'
Plug 'mrjones2014/smart-splits.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'olimorris/codecompanion.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'rhysd/clever-f.vim'
Plug 'rhysd/vim-textobj-word-column'
Plug 'romainl/vim-cool'
Plug 'saaguero/vim-textobj-pastedtext'
Plug 'sindrets/diffview.nvim'
Plug 'stevearc/conform.nvim'
Plug 'stevearc/oil.nvim'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'whatyouhide/vim-textobj-erb'
Plug 'windwp/nvim-autopairs'

call plug#end()

" }}}
" Basic options {{{

" misc
set confirm
set shortmess+=c
set noswapfile
set nowritebackup
set spellfile=~/.config/nvim/spell/custom-dictionary.utf-8.add
set spelllang=pt,en
set undofile
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
set clipboard+=unnamedplus

" better navigation
set foldlevel=99
set gdefault
set ignorecase
set smartcase
set splitbelow
set splitright

" wild stuff
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
set pumheight=20
set laststatus=3

if executable('rg')
  set grepprg=rg\ --vimgrep\ --hidden
  set grepformat=%f:%l:%c:%m,%f:%l:%m,%f:%l%m,%f\ %l%m
endif

" }}}
" Color scheme {{{

set background=dark
set termguicolors

function! init#colorscheme() abort
  hi! EndOfBuffer guibg=bg guifg=bg
  hi! GitSignsDelete guifg=#FF9580
  hi! MatchWord gui=bold
endfunction

augroup vimrc_colorscheme
  au!
  au ColorScheme * call init#colorscheme()
augroup END

colorscheme catppuccin

" }}}
" Mappings {{{

let mapleader = ","
let maplocalleader = "\\"

" Easy command-line mode
map ; :

" Easier bracket matching
map <Tab> %
map <C-o> <nop>

" .: repeats the last command on every line
xnoremap . :normal.<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Always start inserting at the end of input fields
noremap gi gi<End>

" Move to last change
nnoremap gI `.zz

" Center screen
nnoremap gg ggzv
nnoremap G Gzv

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>zz
nnoremap <silent> <c-\> :vertical wincmd ]<cr>zz

" Use Vim's built-in CTRL-R_CTRL-F when no plugin has claimed <Plug><cfile>
if empty(maparg('<Plug><cfile>', 'c'))
  cnoremap <Plug><cfile> <C-R><C-F>
endif

" Helper map to pass the count (e.g., 2gf) to the underlying command
nnoremap <SID>: :<C-U><C-R>=v:count ? v:count : ''<CR>

" `gf` opens file under cursor in a new vertical split
nmap gf <SID>:vert sfind <Plug><cfile><CR>

" I hate when the rendering occasionally gets messed up.
function! s:redraw()
  nohlsearch
  silent! unlet g:test#wezterm#pane_id
  silent! lua require'gitsigns'.refresh()
  silent! lua vim.treesitter.get_parser():parse()
  silent! lua vim.diagnostic.clear()
  redraw!
  normal zx
  echo
endfunction
nnoremap U :call <sid>redraw()<cr>

" Useful mappings for managing tabs
nnoremap          <leader>te <esc>:tabedit<Space>
nnoremap <silent> <leader>tn <esc>:tabnew<cr>
nnoremap <silent> <leader>to <esc>:tabonly<cr>
nnoremap <silent> <leader>td <esc>:tabclose<cr>

" [w ]w - Forward and backwards tabs
nnoremap <silent> [w <esc>:tabprevious<cr>
nnoremap <silent> ]w <esc>:tabnext<cr>

" [W ]W - Move tabs
nnoremap <silent> [W <esc>:tabmove -1<cr>
nnoremap <silent> ]W <esc>:tabmove +1<cr>

" ,[1-5] - Switch to tab #
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt

" Split windows
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" Faster scrolling
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

" Sane movement with wrap turned on
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
vnoremap j gj
vnoremap k gk

" { and } skip over closed folds instead of openning them
nnoremap <expr> } foldclosed(search('^$', 'Wn'))  == -1 ? '}zz' : '}j}zz'
nnoremap <expr> { foldclosed(search('^$', 'Wnb')) == -1 ? '{zz' : '{k{zz'

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

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
noremap X "_d

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
nnoremap ? ms?

" Replace alias
nnoremap s/ mr:%s/

" inVerse search: line NOT containing pattern
cnoremap <m-/> \v^(()@!.)*$<Left><Left><Left><Left><Left><Left><Left>

" Terminal-mode
tnoremap <Esc> <C-\><C-n>
tnoremap <a-a> <esc>a
tnoremap <a-b> <esc>b
tnoremap <a-d> <esc>d
tnoremap <a-f> <esc>f

" Easier dir/file aliases
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'
cnoremap <expr> %< getcmdtype() == ':' ? fnameescape(expand('%:t')) : '%<'

" Open notes directory
nnoremap <silent> <leader>n :tabedit /mnt/c/Users/Rainer Borene/Dropbox/Notebook/Notes<cr>

" Reindent entire file
nnoremap == mqHmwgg=G`wzt`q

" Easy filetype switching
nnoremap =f :setfiletype<Space>

" Insert Mode Completion
imap <c-j> <c-n>
imap <c-k> <c-p>
imap <c-c> <esc>
imap jj <esc>

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

augroup ft_qf
  au!
  au FileType qf setlocal nowrap nonumber norelativenumber | wincmd J
  au FileType qf nnoremap <buffer> <silent> q :<C-u>cclose<CR>
  au FileType qf nnoremap <buffer> <silent> <c-n> :<C-u>cnext<CR>:copen<CR>
  au FileType qf nnoremap <buffer> <silent> <c-p> :<C-u>cprevious<CR>:copen<CR>

  " Automatically opens the quickfix window after :Ggrep.
  au QuickFixCmdPost *grep* cwindow | doautocmd BufReadPost quickfix
augroup END

" }}}
" Autocommands {{{

augroup ft_markdown
  au!
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1
  au FileType markdown nnoremap <buffer> <localleader>1 yypVr=
  au FileType markdown nnoremap <buffer> <localleader>2 yypVr-
  au FileType markdown nnoremap <buffer> <localleader>3 I### <ESC>
  au FileType markdown setlocal wrap linebreak nolist
augroup END

augroup ft_caddy
  au!
  au BufNewFile,BufRead Caddyfile* setlocal filetype=caddy
augroup END

augroup ft_ruby
  au!
  au BufRead *gemrc setlocal filetype=yaml
  au FileType ruby setlocal iskeyword+=!,?
  au FileType ruby setlocal keywordprg=ri\ -T
  au BufNewFile,BufRead .env* set filetype=sh
augroup END

augroup treesitter_folding
  au FileType css,javascript,lua,ruby,sql setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
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

  " More focus on trailing white spaces
  au InsertEnter * set listchars-=trail:⣿
  au InsertLeave * set listchars+=trail:⣿

  " Resize splits when the window is resized
  au VimResized * :wincmd =

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
" Automatically create any non-existent directories before writing the buffer {{{

function! s:Mkdir() abort
  let dir = expand('%:p:h')
  if !isdirectory(dir) && index(["fugitive", "git", "oil"], &ft) == -1
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction
autocmd BufWritePre * call s:Mkdir()

" }}}
" Open NPM package in a new tab {{{

function! s:node_packages(A, L, P)
  return map(split(globpath("node_modules", a:A . "*"), "\n"), 'v:val[strlen("node_modules/"): -1]')
endfunction

function! s:node_topen(package)
  let l:path = 'node_modules/'.a:package
  if isdirectory(l:path)
    silent exe 'tabedit '.l:path
    silent exe 'tcd '.l:path
  end
endfunction

command! -nargs=1 -complete=customlist,s:node_packages Nopen exe s:node_topen(<q-args>)

" }}}
" Plugins {{{

" Lua based {{{

lua require("rainer")

" }}}
" Grug Far {{{

lua require("grug-far").setup()

nnoremap <silent> <leader>x <cmd>lua require('grug-far').toggle_instance({ instanceName='far', staticTitle='Search and Replace' })<CR>
nnoremap <silent> <leader>X <cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<CR>

" }}}
" Ruby {{{

let g:no_ruby_maps = 1

" }}}
" Rails {{{

let g:rails_projections = {
      \ "app/components/*_component.rb": {
      \   "command": "component",
      \   "template": ["class {camelcase|capitalize|colons}Component < ApplicationComponent", "end"],
      \   "related": "app/components/{}_component.html.erb"
      \ },
      \ "app/components/*_component.html.erb": {
      \   "related": "app/components/{}_component.rb",
      \   "alternate": "test/components/{}_component_test.rb"
      \ }}

" }}}
" SQL {{{

let g:omni_sql_no_default_maps = 0

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
" Snacks {{{

nnoremap <leader><leader> :lua Snacks.picker.files()<cr>
nnoremap <leader><tab> :lua Snacks.picker.keymaps()<cr>
nnoremap <leader>. :lua Snacks.picker.lsp_workspace_symbols()<cr>
nnoremap <leader>k :lua Snacks.picker.help()<cr>
nnoremap <leader>b :lua Snacks.picker.buffers()<cr>
nnoremap <leader>a :lua Snacks.picker.grep()<cr>
noremap <leader>A :lua Snacks.picker.grep_word()<CR>
nnoremap <leader>f :lua Snacks.picker.grep_word({ search = vim.fn.input("Grep For > "), regex = true })<cr>
nnoremap <leader>F :lua require('rainer.snacks').bundle_grep_word()<cr>

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
" Conform {{{

map <F8> :Format<cr>

" }}}
" Lint {{{

augroup lint
  au!
  au BufEnter,BufWritePost * silent! lua require('lint').try_lint()
  au InsertLeave * silent! lua require('lint').try_lint()
augroup END

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
" SmartSplits {{{

lua require('smart-splits').setup({ at_edge = 'stop' })

" Resize splits
nnoremap <silent> <A-h> :lua require('smart-splits').resize_left()<CR>
nnoremap <silent> <A-j> :lua require('smart-splits').resize_down()<CR>
nnoremap <silent> <A-k> :lua require('smart-splits').resize_up()<CR>
nnoremap <silent> <A-l> :lua require('smart-splits').resize_right()<CR>

" Moving between splits
nnoremap <silent> <C-h> :lua require('smart-splits').move_cursor_left()<CR>
nnoremap <silent> <C-j> :lua require('smart-splits').move_cursor_down()<CR>
nnoremap <silent> <C-k> :lua require('smart-splits').move_cursor_up()<CR>
nnoremap <silent> <C-l> :lua require('smart-splits').move_cursor_right()<CR>

" }}}
" Wezterm {{{

function! s:wezterm_set_user_var(name, value)
  return printf("\033]1337;SetUserVar=%s=%s\007", a:name, system("base64 -", a:value))
endfunction

augroup wezterm
  au!
  autocmd DirChanged * call chansend(v:stderr, printf("\033]7;file://%s\033\\", v:event.cwd))
  autocmd BufWritePost *wezterm.lua call chansend(v:stderr, s:wezterm_set_user_var("reload_configuration", "_"))
  autocmd ExitPre * call system('wezterm cli set-tab-title '.fnamemodify(getcwd(), ":t"))
  autocmd BufEnter *
        \  if empty(&buftype)
        \|   call jobstart('wezterm cli set-tab-title '.expand('%:t:S'))
        \| endif
augroup END

augroup wezterm_fix
  au!
  autocmd BufEnter /tmp/psql* au! wezterm
augroup END

" }}}
" LSP {{{

nnoremap <silent> <leader>ld :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>li :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>ls :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>le :lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>lr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>lh :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>la :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ll :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" }}}
" Test {{{

let test#strategy = "wezterm"

nmap <silent> <leader>rr :TestNearest<CR>
nmap <silent> <leader>rf :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rg :TestVisit<CR>

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
" Oil {{{

nnoremap <silent> <leader>e :Oil<cr>

" }}}
" Gitsigns {{{

nnoremap <silent> <expr> [c &diff ? '[c' : "\<Cmd>Gitsigns prev_hunk\<CR>"
nnoremap <silent> <expr> ]c &diff ? ']c' : "\<Cmd>Gitsigns next_hunk\<CR>"
onoremap <silent> ih :<C-u>Gitsigns select_hunk<CR>
xnoremap <silent> ih :<C-u>Gitsigns select_hunk<CR>
nnoremap <leader>hs :Gitsigns stage_buffer<cr>
nnoremap <leader>hu :Gitsigns undo_stage_hunk<cr>
nnoremap <leader>hr :Gitsigns reset_hunk<cr>
nnoremap <leader>hp :Gitsigns preview_hunk<cr>

" }}}
" Matchup {{{

let g:matchup_matchparen_offscreen = {}

" }}}
" Codecompanion {{{

augroup llm_plugin
  au!
  au User CodeCompanionDiffAttached nnoremap <silent> <buffer> q :bd!<cr>
  au User CodeCompanionChatOpened set conceallevel=2
  au User CodeCompanionChatClosed set conceallevel&
augroup END

cnoreabbrev cc CodeCompanionChat

nnoremap <leader>C :%CodeCompanion<Space>

" }}}
" Targets {{{

autocmd User targets#mappings#user call targets#mappings#extend({
    \ '\': {'separator': [{'d': '::'}]},
    \ })

" }}}

" }}}
