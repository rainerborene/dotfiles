" .vimrc
source ~/.config/nvim/plugged.vim

set autowrite
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
set linebreak
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set noshowmode
set noswapfile
set notimeout
set nowritebackup
set nrformats-=octal
set shiftwidth=2
set shortmess=aoOtI
set showbreak=↪
set showcmd
set smartcase
set spellfile=~/.vim/spell/custom-dictionary.utf-8.add
set spelllang=pt,en
set splitbelow
set splitright
set tabstop=4
set textwidth=80
set ttimeout
set ttimeoutlen=100
set undofile
set undoreload=10000
set virtualedit+=block
set visualbell

" Statusline {{{1

set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

" }}}1
" Color scheme {{{1

let g:base16colorspace=256
set background=dark
colorscheme base16-ocean

hi VertSplit ctermbg=NONE guibg=NONE
hi ExtraWhitespace ctermbg=red guibg=red

" }}}1
" Wilmenu completion {{{1

set wildmode=list:longest,full
set wildignore+=*.DS_Store
set wildignore+=*~,.git,*.pyc,*.o,*.spl,*.rdb
set wildignore+=.sass-cache

" }}}1
" Neovim {{{1

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" }}}1
" Mappings {{{1

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

" Search-replace.
nnoremap g/ ms:<c-u>OverCommandLine<cr>%s/\v
xnoremap g/ ms:<c-u>OverCommandLine<cr>%s/\%V\v

" I hate when the rendering occasionally gets messed up.
nnoremap <silent> U :syntax sync fromstart<cr>:redraw!<cr>

" Sort lines
nnoremap gs vip:!sort<cr>
vnoremap gs :!sort<cr>

" Speed up window switching
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v

" Fast tab switching
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>t :tabnew<CR>

" Fast scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

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

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)

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

" Send to the black hole register
noremap x "_x
noremap X "_X

" Preserve previous paste
vnoremap p pgvy

" Multiblock
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)

" Save
inoremap <C-s> <C-o>:update<cr>
nnoremap <C-s> :update<cr>

" Search
vnoremap <leader>a "zy:execute "Ag " . @z<cr>
nnoremap <leader>a :Ag<Space>

" Rebuild Ctags
nnoremap <silent> g<cr> :!ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Undo tree usable by humans
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" Fuzzy finder
nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>. :Tags<CR>

" Open NERDTree file explorer
nnoremap <leader>e :e <c-r>=expand('%:p:h') . '/'<cr><cr>

" Fugitive
nnoremap <silent> <leader>gd :Gvdiff -<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gl :Glog<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>
nmap <silent> <leader>gs :Gstatus<cr>gg<c-n>

" Easy filetype switching
nnoremap =f :setfiletype<Space>

" Insert Mode Completion
imap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
imap <c-x><c-j> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-j> <c-n>
imap <c-k> <c-p>

" }}}1
" Autocommands {{{1

augroup ft_postgres
  au!
  au BufNewFile,BufRead /tmp/sql*,*.sql,*psql*, set filetype=pgsql
  au FileType pgsql set softtabstop=2 shiftwidth=2
  au FileType pgsql set foldmethod=indent
  au FileType pgsql setlocal commentstring=--\ %s comments=:--
augroup END

augroup ft_fish
  au!
  au BufNewFile,BufRead *.fish set filetype=fish
  au FileType fish setlocal foldmethod=marker foldmarker={{{,}}}
  au FileType fish setlocal commentstring=#\ %s
augroup END

augroup ft_javascript
  au!
  au BufNewFile,BufRead .jshintrc,*.es6 set filetype=javascript
  au FileType javascript setlocal foldmethod=marker foldmarker={,}
  au FileType javascript let b:switch_custom_definitions = g:switch_javascript_definitions
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

augroup ft_go
  au!
  au FileType go setlocal commentstring=\/\/\ %s
augroup END

augroup vimrc
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType qf,nerdtree setlocal colorcolumn& nocursorline nolist nowrap tw=0
  au FileType qf setlocal nolist nowrap | wincmd J | nnoremap <buffer> q :q<cr>
  au BufWinEnter *.txt if &ft == 'help' | wincmd T | nnoremap <buffer> q :q<cr> | endif

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

augroup Neomake
  au!
  au BufWritePost * Neomake
augroup END

augroup Oblique
  au!
  au User Oblique       normal! zz
  au User ObliqueStar   normal! zz
  au User ObliqueRepeat normal! zz
augroup END

augroup AfterObject
  au!
  au VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
augroup END

augroup Over
  au!
  au User OverCmdLineExecute
        \ if line("'s") |
        \   call cursor(line("'s"), col("'s")) |
        \   delmarks s |
        \ endif
augroup END

" }}}1
" Quickfix niceties {{{1

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

" }}}1
" Folding {{{1

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

" }}}1
" Automatically create any non-existent directories before writing the buffer {{{1

function! s:Mkdir()
  let dir = expand('%:p:h')
  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction
autocmd BufWritePre * call s:Mkdir()

" }}}1
" Plugin configuration {{{1

" Ruby {{{2

let g:ruby_fold = 1
let g:ruby_no_expensive = 1

" }}}2
" HTML5 {{{2

let g:html_indent_tags = 'li\|p'

" }}}2
" Surround {{{2

let g:surround_no_insert_mappings = 1

" }}}2
" NERDTree {{{2

let g:NERDTreeHijackNetrw = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapJumpNextSibling = 'gj'
let g:NERDTreeMapJumpPrevSibling = 'gk'

" }}}2
" Switch {{{2

let g:switch_mapping = "-"
let g:switch_javascript_definitions = [{
      \ '\[["'']\(\k\+\)["'']\]': '\.\1',
      \ '\.\(\k\+\)': '[''\1'']'
      \ }]

" }}}2
" DelimitMate {{{2

let g:delimitMate_expand_cr = 1

" }}}2
" Undotree {{{2

let g:undotree_WindowLayout = 2

" }}}2
" FZF {{{2

let g:fzf_layout = { 'down': '10%' }

function! s:fzf_statusline()
  highlight fzf1 ctermfg=19 ctermbg=0
  highlight fzf2 ctermfg=20 ctermbg=0
  highlight fzf3 ctermfg=20 ctermbg=0
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}2

" }}}1
