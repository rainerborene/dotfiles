" .vimrc
source ~/.dotfiles/.vimrc.bundles

set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set colorcolumn=+1
set complete-=i
set completeopt=longest,menuone
set confirm
set display+=lastline
set encoding=utf-8
set expandtab
set fillchars=diff:⣿,vert:│
set foldlevel=99
set formatoptions=qrn1j
set gdefault
set hidden
set history=1000
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set noshowmode
set noswapfile
set nrformats-=octal
set shiftwidth=2
set shortmess=aoOtI
set showcmd
set smartcase
set smarttab
set spellfile=~/.vim/spell/custom-dictionary.utf-8.add
set spelllang=pt,en
set splitbelow
set splitright
set tabstop=4
set textwidth=80
set ttimeout
set ttimeoutlen=100
set virtualedit+=block
set wrap

" Environments (GUI/Console) {{{1

if has("gui_running")
  set guifont=Termsynu\ 10
  set guioptions=agit
else
  let g:base16colorspace=256
  set mouse=a
end

" }}}1
" Color scheme {{{1

set background=dark
colorscheme base16-ocean

hi VertSplit ctermbg=NONE guibg=NONE

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}1
" Statusline {{{1

set statusline=%f%m\ %{fugitive#statusline()}%=
set statusline+=(%{&ff}/%{strlen(&fenc)?&fenc:&enc}/%{strlen(&ft)?&ft:'none'})
set statusline+=\ (line\ %l/%L,\ col\ %03c)

" }}}1
" Wilmenu completion {{{1

set wildmenu
set wildmode=list:longest,full
set wildignore+=*.DS_Store
set wildignore+=*~,.git,*.pyc,*.o,*.spl,*.rdb
set wildignore+=.sass-cache

" }}}1
" Persistent undo {{{1

set undofile
set undoreload=10000
set undodir=~/.vim/tmp/undo

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
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

" Insert mode undo.
inoremap <C-U> <C-G>u<C-U>

" Clean trailing whitespace
nnoremap <silent> =w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z

" Search-replace.
nnoremap g/ ms:<c-u>OverCommandLine<cr>%s/
xnoremap g/ ms:<c-u>OverCommandLine<cr>%s/\%V

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

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" Focus the current fold by folding all the others
nnoremap <leader>z zMzvzz

" Command history navigation
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>

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

" Rebuild Ctags
nnoremap <silent> g<cr> :call vimproc#system('ctags -R . &')<cr>

" Undo tree usable by humans
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" Unite
nnoremap <leader>, :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<CR>
nnoremap <expr> <leader>a ":\<C-u>Unite -no-split -buffer-name=grep%".tabpagenr()." -no-empty -resume -auto-preview grep\<cr>"
vnoremap <leader>a "zy:execute "Unite -no-split -buffer-name=grep%".tabpagenr()." -no-empty -auto-preview grep:.::" . @z<cr>"

" File explorer
nnoremap <silent> <leader>e :VimFilerBufferDir<CR>

" Fugitive
nnoremap <silent> <leader>gd :Gvdiff -<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gl :Glog<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>

" Easy filetype switching
nnoremap =f :setfiletype<Space>

" Insert Mode Completion
" Note that <C-@> is triggered by <C-Space> in many terminals.
inoremap <C-]> <C-x><C-]>
inoremap <C-l> <C-x><C-l>
inoremap <C-@> <C-x><C-o>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" }}}1
" Autocommands {{{1

augroup ft_postgres
  au!
  au BufNewFile,BufRead *.sql,*psql* set filetype=pgsql
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
augroup END

augroup ft_html
  au!
  au FileType html,eruby setlocal foldmethod=manual
  au FileType html,eruby nnoremap <buffer> <localleader>f Vatzf
  au FileType html,eruby nnoremap <buffer> <localleader>= Vat=
augroup END

augroup ft_awk
  au FileType awk setlocal commentstring=#\ %s
augroup END

augroup ft_i3
  au!
  au BufRead,BufNewFile *i3/config set ft=i3
augroup END

augroup ft_git
  au!
  au FileType git,gitcommit setlocal foldmethod=syntax colorcolumn& nolist
  au FileType gitcommit nmap <silent> <buffer> U :call system("git checkout -- <C-r><C-g>")<CR>R
  au FileType gitcommit setlocal spell | wincmd K
  au BufReadPost fugitive://* set bufhidden=delete
  au QuickFixCmdPost *grep* cwindow
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

augroup ft_tmux
  au!
  au BufNewFile,BufRead .tmux.conf setlocal commentstring=#\ %s
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

augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType man,help wincmd L | setlocal textwidth=78
  au FileType qf nnoremap <buffer> <cr> <cr>
  au FileType qf setlocal colorcolumn& nocursorline nolist nowrap tw=0
  au FileType qf setlocal nolist nowrap | wincmd J | nnoremap <buffer> q :q<cr>
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

augroup ft_ruby
  au!
  au BufRead *gemrc setlocal filetype=yaml
  au FileType ruby setlocal foldmethod=syntax
  au FileType ruby setlocal keywordprg=ri\ -T
augroup END

augroup ft_go
  au!
  au FileType godoc wincmd L | nnoremap <buffer> <silent> K :q<cr>
  au FileType go setlocal commentstring=\/\/\ %s
augroup END

augroup scriptease_help
  au!
augroup END

" Save when losing focus
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * :wincmd =

" No folds closed when editing new files
au BufNew * setlocal foldlevelstart=99

" Restore cursor position
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

augroup search_position
  autocmd!
  autocmd User OverCmdLineExecute call KeepCursorPosition()
augroup END

function! KeepCursorPosition()
  if line("'s")
    call cursor(line("'s"), col("'s"))
    delmarks s
  endif
endfunction

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
augroup fast_completion
  au!
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
augroup END

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

let g:ruby_space_errors = 1
let g:ruby_operators = 1

" }}}2
" HTML5 {{{2

let g:html_indent_tags = 'li\|p'

" }}}2
" Syntastic {{{2

let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_auto_loc_list = 2
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'passive_filetypes': ['html', 'yaml']
      \ }

" }}}2
" Sparkup {{{2

let g:sparkupNextMapping = '<c-y>'

" }}}2
" Surround {{{2

let g:surround_no_insert_mappings = 1

" }}}2
" Unite {{{2

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/git,buffer', 'ignore_pattern', '\v\.(git|png|jpg|gif)$')

let g:unite_source_history_yank_enable = 1
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup --hidden'
let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --hidden -U -g ""'

function! s:unite_settings()
  let b:delimitMate_autoclose = 0
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <silent> <C-z> <Plug>(unite_toggle_mark_current_candidate)
  imap <silent> <buffer> <expr> <C-x> unite#do_action('split')
  imap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  imap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <expr> v unite#do_action('vsplit')
endfunction
autocmd FileType unite call s:unite_settings()

" }}}2
" VimFiler {{{2

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = '\v\.(git|DS_Store|pyc)$'

 " Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

call vimfiler#custom#profile('default', 'context', {
      \ 'safe' : 0,
      \ 'auto_expand' : 1,
      \ 'parent' : 0,
      \ })

" }}}2
" Switch {{{2

let g:switch_mapping = "-"
let g:switch_custom_definitions = []

" Dot notation
call add(switch_custom_definitions, {
      \ '\[["'']\(\k\+\)["'']\]': '\.\1',
      \ '\.\(\k\+\)': '[''\1'']'
      \ })

" }}}2

" }}}1
