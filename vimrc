" Essentials --------------------------------------------------------------- {{{

filetype off
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on

" }}}
" Basic settings ----------------------------------------------------------- {{{

set nocompatible
set history=1000
set autoread
set autowrite
set hidden
set spelllang=pt,en
set encoding=utf-8
set nobomb
set undoreload=10000
set undofile
set shiftround
set updatecount=20
set ttimeout
set nottimeout
set ttyfast
set splitbelow
set splitright
set shell=/bin/bash
set lazyredraw
set matchtime=3
set dictionary=/usr/share/dict/words

" }}}
" Appearance --------------------------------------------------------------- {{{

syntax on
set t_Co=256
set title
set cursorline
set backspace=indent,eol,start
set showcmd
set noshowmode
set wildmenu
set wildmode=list:longest,full
set wildignore+=*~,.git,*.pyc,*.o,tags,tmp
set wildignore+=*.DS_Store
set wildignore+=.sass-cache
set ruler
set nonumber
set norelativenumber
set numberwidth=5
set pumheight=10
set showbreak=↪
set virtualedit+=block
set shortmess=atI
set mousemodel=popup
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set mouse=a
set ttymouse=xterm2
set background=dark
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)
set colorcolumn=+1
set synmaxcol=500

let g:badwolf_tabline = 2
let g:badwolf_html_link_underline = 0
let g:badwolf_css_props_highlight = 1
colorscheme badwolf

if has("gui_running")
  " Remove all the UI cruft
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R

  highlight SpellBad term=underline gui=undercurl guisp=Orange

  if has("mac")
    set guifont=Menlo:h12
    set fuoptions=maxvert,maxhorz
  elseif has("unix")
    set guifont=bitstream\ vera\ sans\ mono\ 9
    set lines=999 columns=999
  endif
end

" }}}
" Backups ------------------------------------------------------------------ {{{

set backup
set noswapfile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" }}}
" Visual Cues -------------------------------------------------------------- {{{

set visualbell t_vb=
set ignorecase
set smartcase
set foldlevelstart=0
set laststatus=2
set incsearch
set hlsearch
set nostartofline
set gdefault
set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set fillchars=vert:\│
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set list

" }}}
" Text Formatting ---------------------------------------------------------- {{{

set autoindent
set smartindent
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set textwidth=80
set formatoptions=qrn1
set nojoinspaces
set wrap linebreak
set nrformats=

" }}}
" Filetype-specific -------------------------------------------------------- {{{

au FileType html,css,scss,ruby,pml,yaml,coffee,vim,js setlocal ts=2 sts=2 sw=2 expandtab
au FileType php,apache,sql,xslt,gitconfig,objc setlocal ts=4 sts=4 sw=4 noexpandtab
au FileType python setlocal ts=4 sts=4 sw=4 expandtab
au FileType html,xml,js,css,php autocmd BufWritePre <buffer> :call StripWhitespace()
au FileType java silent! compiler javac | setlocal makeprg=javac\ %
au FileType c setlocal foldmethod=syntax

au BufRead,BufNewFile *.tumblr.html setfiletype tumblr
au BufNewFile,BufRead *.ejs setfiletype html
au BufNewFile,BufRead *.rss setfiletype xml
au BufNewFile,BufRead {Rakefile,Vagrantfile,Guardfile,Capfile,Thorfile,Gemfile,pryrc,config.ru} setfiletype ruby
au BufReadPost fugitive://* set bufhidden=delete
au BufWritePost .vimrc source $MYVIMRC

augroup ft_org
  au!
  au FileType org setlocal formatoptions+=t colorcolumn&
augroup END

augroup ft_fish
  au!
  au BufNewFile,BufRead *.fish setlocal filetype=fish
  au FileType fish setlocal foldmethod=marker foldmarker={{{,}}}
  au FileType fish setlocal commentstring=#\ %s
  au FileType fish let b:vimpipe_command="fish <(cat)"
augroup END

augroup ft_git
  au!
  au FileType git,gitv setlocal colorcolumn&
  au FileType gitcommit setlocal spell | wincmd K
augroup END

augroup ft_mongo
  au!
  au BufNewFile,BufReadPost *.mql setlocal filetype=mongoql
  au FileType mongoql let b:vimpipe_command="mongo"
  au FileType mongoql let b:vimpipe_filetype="json"
augroup END

augroup ft_ruby
  au!
  au FileType ruby nnoremap <buffer> <localleader>gem ^igem 'Whha',f(r'a~> f)r'U
  au FileType ruby silent! setlocal foldmethod=indent
  au FileType ruby silent! compiler ruby
  au FileType ruby let b:vimpipe_command='ruby <(cat)'
augroup END

augroup ft_json
  au!
  au FileType json let b:vimpipe_command="python -m json.tool"
augroup END

augroup ft_css
  au!
  au FileType css setlocal foldmethod=marker foldmarker={,}
  au FileType css nnoremap <localleader>s vi{:!sort<CR>
augroup END

augroup ft_html
  au!
  au FileType html setlocal foldmethod=manual
  au FileType html let b:vimpipe_command="lynx -dump -stdin"
augroup END

augroup ft_quickfix
  au!
  au FileType qf setlocal colorcolumn& nolist nocursorline nowrap tw=0
augroup END

augroup ps_nerdtree
  au!
  au FileType nerdtree setlocal colorcolumn&
augroup END

augroup ft_markdown
  au!
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown
  au FileType markdown nnoremap <buffer> <localleader>1 yypVr=
  au FileType markdown nnoremap <buffer> <localleader>2 yypVr-
  au FileType markdown nnoremap <buffer> <localleader>3 I### <ESC>
  au FileType markdown setlocal wrap linebreak nolist
  au FileType markdown let b:vimpipe_command="multimarkdown"
  au FileType markdown let b:vimpipe_filetype="html"
augroup END

augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

augroup ft_javascript
  au!
  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}
augroup END

" Only show cursorline in the current window and in normal mode.
augroup cline
  au!
  au WinLeave * set nocursorline
  au WinEnter * set cursorline
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END

" Only shown when not in insert mode so I don't go insane.
augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:⌴
  au InsertLeave * :set listchars+=trail:⌴
augroup END

" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Make terminal Vim trigger autoread more often.
au WinEnter,BufWinEnter,CursorHold * checktime

" Restore cursor position
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" }}}
" Mappings ----------------------------------------------------------------- {{{

" Leader keys
let mapleader = ","
let maplocalleader = "\\"

" Easier bracket matching
map <Tab> %

" Delete a buffer without closing the window
nmap <leader>q <Plug>Kwbd

" Wipe all buffers which are not active
nmap <leader>hq <Plug>CloseHiddenBuffers

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Use the old surround.vim key.  I can't deal with the new one.
vmap s S

" Don't move on *
nnoremap * *<c-o>

" Switch segments of text with predefined replacements
nnoremap - :Switch<cr>

" For some reason pastetoggle doesn't redraw the screen (thus the status bar
" doesn't change) while :set paste! does, so I use that instead.
nnoremap <silent> <F6> :set paste!<CR>

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-\> <c-w>v<c-]>zvzz

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Make Y consistent with C and D
nnoremap Y y$

" Select just-pasted text
nnoremap gV `[v`]

" Move to last change
nnoremap gI `.

" Enter command mode quickly
nnoremap ; :

" Cmdheight switching
nnoremap <leader>1 :set cmdheight=1<cr>
nnoremap <leader>2 :set cmdheight=2<cr>

" Fuck you too, manual key.
nnoremap K <nop>

" Kill window
nnoremap K :q<cr>

" I hate when the rendering occasionally gets messed up.
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Sort lines
vnoremap <leader>s :!sort<cr>

" Speed up buffer switching
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>w
nnoremap <C-k> <C-W>W
nnoremap <C-l> <C-W>l
nnoremap <leader>v <C-w>v

" Tiled Window Management
nmap <C-N> <Plug>DWMNew
nmap <C-C> <Plug>DWMClose
nmap <C-@> <Plug>DWMFocus
nmap <C-Space> <Plug>DWMFocus

" Easy filetype switching
nnoremap _fs :setf fish<CR>
nnoremap _ss :setf sass<CR>
nnoremap _ht :setf html<CR>
nnoremap _vi :setf vim<CR>
nnoremap _ob :setf objc<CR>
nnoremap _rb :setf ruby<CR>
nnoremap _tu :setf tumblr<CR>
nnoremap _js :setf javascript<CR>
nnoremap _sql :setf sql<CR>

" View full list of vim's syntax groups
nnoremap <leader>hi :source $VIMRUNTIME/syntax/hitest.vim<CR>

" Omni completion
inoremap <c-l> <c-x><c-l>
inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>

" Sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
vnoremap <Up> gk
vnoremap <Down> gj

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" Abbreveations
iabbrev enc # encoding: utf-8

" Emacs bindings in command line and insert modes.
cnoremap <c-a> <home>
cnoremap <c-e> <end>
inoremap <c-a> <home>
inoremap <c-e> <end>

" Source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Clam
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Jump to line and column
noremap ' `

" Regenerate ctags
nnoremap <leader><cr> :silent !/usr/local/bin/ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Because escape is too far away
inoremap jj <ESC>

" Learning, the hard way.
inoremap <Left>  <nop>
inoremap <Right> <nop>
inoremap <Up>    <nop>
inoremap <Down>  <nop>

" Toggle 'keep current line in the center of the screen' mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Shortcut for []
onoremap id i[
onoremap ad a[
vnoremap id i[
vnoremap ad a[

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" Cursor happens to be.
nnoremap zO zCzO

" Focus the current fold by folding all the others
nnoremap <leader>z zMzvzz

" Duplication
nnoremap <leader>d mz"dyy"dp`z
vnoremap <leader>d "dymz"dP`z``

" The black hole register
noremap x "_x

" Diffoff
nnoremap <silent> <leader>D :diffoff!<cr>

" Clear search highlight
nnoremap <silent> <leader>/ :silent :nohlsearch<CR>

" Open CtrlP on different modes
nnoremap <silent> <leader>t :CtrlPTag<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>l :CtrlPLine<CR>

" Some toggle commands
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap <silent> <leader>i :set list!<CR>
nnoremap <silent> <leader>u :GundoToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>

" Yank to OS X pasteboard.
noremap <leader>y "*y

" Paste from OS X pasteboard without messing up indent.
noremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"*P<CR>:set nopaste<CR>

" Ack searching
noremap <leader>a :Ack!<space>

" Turbux
map <leader>r <Plug>SendTestToTmux
map <leader>R <Plug>SendFocusedTestToTmux

" Fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gh :Gbrowse<cr>
nnoremap <leader>gco :Gread<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<space>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gv :Gitv --all<cr>
nnoremap <leader>gV :Gitv! --all<cr>

" }}}
" Trailing whitespace ------------------------------------------------------ {{{

function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>w :call StripWhitespace()<CR>

" }}}
" Visual Mode */# from Scrooloose ------------------------------------------ {{{

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" }}}
" Image dimensions --------------------------------------------------------- {{{

function! s:FindImages(ArgLead, CmdLine, CursorPos)
  return system("find * -name '*.png' -or -name '*.jpg'")
endfunction

function! s:Dimensions(image)
  let output = system("sips -g pixelWidth -g pixelHeight " . a:image)
  let width = matchlist(output, '\vpixelWidth: (\d+)')[1]
  let height = matchlist(output, '\vpixelHeight: (\d+)')[1]
  let @z = join(["  width: ".width."px;", "  height: ".height."px;"], "\n")
  silent normal! mz"zpvis=`z
endfunction
command! -complete=custom,s:FindImages -nargs=1 Dimensions call s:Dimensions(<f-args>)

" }}}
" Synstack ----------------------------------------------------------------- {{{

" Show highlighting groups for current word
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc
nnoremap <F7> :call SynStack()<CR>

" }}}
" Scratch ------------------------------------------------------------------ {{{

function! ScratchToggle()
  if exists("w:is_scratch_window")
    unlet w:is_scratch_window
    exec "q"
  else
    exec "normal! :Sscratch\<cr>\<C-W>L"
    let w:is_scratch_window = 1
  endif
endfunction
command! ScratchToggle call ScratchToggle()
nnoremap <silent> <leader><tab> :ScratchToggle<cr>

" }}}
" Twiddle case ------------------------------------------------------------- {{{

" http://vim.wikia.com/wiki/Switching_case_of_characters
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

" }}}
" Tab title ---------------------------------------------------------------- {{{

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'
    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label = bufname(buflist[winnr - 1])
  return fnamemodify(label == '' ? "untitled" : label, ":t")
endfunction

set guitablabel=%t
set tabline=%!MyTabLine()


" }}}
" Tabularize --------------------------------------------------------------- {{{

function! CustomTabularPatterns()
  if exists('g:tabular_loaded')
    AddTabularPattern! symbols         / :/l0
    AddTabularPattern! hash            /^[^>]*\zs=>/
    AddTabularPattern! chunks          / \S\+/l0
    AddTabularPattern! assignment      / = /l0
    AddTabularPattern! comma           /^[^,]*,/l1
    AddTabularPattern! colon           /:\zs /l0
    AddTabularPattern! options_hashes  /:\w\+ =>/
  endif
endfunction
autocmd VimEnter * call CustomTabularPatterns()

" }}}
" Folding ------------------------------------------------------------------ {{{

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
" Quick editing ------------------------------------------------------------ {{{

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>eo :vsplit ~/Dropbox/outline.org<CR>
nnoremap <silent> <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nnoremap <silent> <leader>et :vsplit ~/.tmux.conf<CR>
nnoremap <silent> <leader>ep :vsplit ~/.pentadactylrc<CR>

" }}}
" Plugin settings ---------------------------------------------------------- {{{

let g:dwm_map_keys = 0
let g:no_turbux_mappings = 1
let g:turbux_command_prefix = 'bundle exec'
let g:nrrw_rgn_vert = 1
let g:nrrw_rgn_wdth = 80
let g:nrrw_rgn_hl = 'Folded'
let g:nrrw_topbot_leftright = 'botright'
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'open %URL% &'
let g:tslime_ensure_trailing_newlines = 1
let g:tslime_normal_mapping = '<localleader>t'
let g:tslime_visual_mapping = '<localleader>t'
let g:tslime_vars_mapping = '<localleader>T'
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:NERDCreateDefaultMappings = 0
let g:NERDTreeChDirMode = 1
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDSpaceDelims = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_OpenHorizontal = 1
let g:Gitv_DoNotMapCtrlKey = 1
let g:ackprg = 'ack-grep -H --nocolor --nogroup --column'
let g:sparkupNextMapping = '<c-o>'
let g:gundo_help = 0
let g:gundo_preview_bottom = 1
let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = '\.jpg$\|\.bmp$\|\.gif$\|\.png$\|\.jpeg$'
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'badwolf'
let g:SuperTabDefaultCompletionType = '<c-n>'
let g:SuperTabLongestHighlight = 1
let g:org_plugins = ['ShowHide', '|', 'Navigator', 'EditStructure', '|', 'Todo']
let g:org_agenda_files = ['~/Dropbox/outline.org']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_enable_signs = 1
let g:syntastic_quiet_warnings = 0
let g:syntastic_auto_loc_list = 2
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['html'] }
let g:surround_indent = 1
let g:surround_{char2nr('-')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('8')} = "/* \r */"
let g:surround_{char2nr('s')} = " \r"
let g:surround_{char2nr('^')} = "/^\r$/"

" }}}

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
