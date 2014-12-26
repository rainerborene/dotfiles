" .vimrc
source ~/.dotfiles/.vimrc.bundles

runtime plugin/rsi.vim
runtime plugin/sensible.vim
runtime plugin/scriptease.vim

set hidden
set confirm
set nobackup
set autowrite
set noswapfile
set noshowmode
set splitbelow
set splitright
set foldlevel=99
set spelllang=pt,en
set spellfile=~/.vim/spell/custom-dictionary.utf-8.add
set dictionary=/usr/share/dict/words
set wildmode=list:longest,full
set wildignore+=*~,.git,*.pyc,*.o,*.spl,*.rdb
set wildignore+=*.DS_Store
set wildignore+=.sass-cache
set completeopt=longest,menuone
set fillchars=diff:⣿,vert:│
set pastetoggle=<F6>
set linebreak
set ignorecase
set smartcase
set hlsearch
set gdefault
set mouse=a
set virtualedit+=block
set colorcolumn=+1
set shortmess=atI
set textwidth=80
set formatoptions=qrn1
set lazyredraw
set shiftwidth=2
set tabstop=4
set expandtab
set wrap

" Color scheme {{{1

set background=dark
let g:solarized_bold = 0
let g:solarized_underline = 0
let g:solarized_termtrans = 1
colorscheme solarized

hi VertSplit ctermbg=NONE

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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

" Clean trailing whitespace
nnoremap <silent> =w mz:silent! %s/\s\+$//<cr>:let @/=''<cr>`z

" Switch segments of text with predefined replacements
nnoremap <silent> - :Switch<cr>

" Use c-\ to do c-] but open it in a new split.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z

" Use sane regexes and mark position before search.
nnoremap / ms/\v
nnoremap ? ms?\v

" Search within visual block
xnoremap / <esc>/\%V\v
xnoremap ? <esc>?\%V\v

" Fast esc key
inoremap jj <Esc>

" Substitute.
xnoremap s :s/\v/g<Left><Left>

" Auto center
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> g; g;zz
nnoremap <silent> g, g,zz

" Don't move on *
nnoremap * *<c-o>

" I hate when the rendering occasionally gets messed up.
nnoremap <silent> U :syntax sync fromstart<cr>:redraw!<cr>

" Sort lines
nnoremap gs vip:!sort<cr>
vnoremap gs :!sort<cr>

" Yankstack
nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste

" UltiSnips trigger keys
inoremap <C-c> <Nop>
inoremap <C-b> <Nop>

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
nnoremap <C-t> :tabnew<CR>

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

" Clam
nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" Kill window
nnoremap K :q<cr>

" Select just-pasted text
nnoremap gV `[v`]

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

" Rebuild Ctags (mnemonic RC -> CR -> <cr>)
nnoremap <silent> g<cr> :!ctags -R . 2>/dev/null &<CR><CR>:redraw!<CR>

" Clear search highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Undo tree usable by humans
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" Unite
nnoremap <leader>, :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/git<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer buffer<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<CR>
nnoremap <leader>a :<C-u>Unite -no-split -buffer-name=grep -no-empty -resume -auto-preview grep<cr>
vnoremap <leader>a "zy:execute "Unite -buffer-name=grep -no-empty -resume -auto-preview grep:.::" . @z<cr>

" File explorer
nnoremap <silent> <leader>e :VimFilerBufferDir<CR>

" Fugitive
nnoremap <silent> <leader>gd :Gvdiff -<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gl :Glog<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>

" Linediff
vnoremap <leader>l :Linediff<cr>
nnoremap <leader>L :LinediffReset<cr>

" Dispatch
nnoremap dm :Make<CR>
nnoremap dr :Start<CR>
nnoremap d! :Dispatch!<CR>
nnoremap d<CR> :Dispatch<CR>
nnoremap d<Space> :Dispatch<Space>

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
  au FileType fish let b:vimpipe_command="fish <(cat)"
augroup END

augroup ft_javascript
  au!
  au BufNewFile,BufRead .jshintrc,*.es6 set filetype=javascript
  au FileType javascript setlocal foldmethod=marker foldmarker={,}
  au FileType javascript let b:vimpipe_command="node"
  au FileType javascript let b:switch_custom_definitions =
        \ [
        \   switch_custom.dot_notation
        \ ]
augroup END

augroup ft_html
  au!
  au FileType html,eruby setlocal foldmethod=manual
  au FileType html,eruby nnoremap <buffer> <localleader>f Vatzf
  au FileType html,eruby nnoremap <buffer> <localleader>= Vat=
augroup END

augroup ft_muttrc
  au!
  au BufRead,BufNewFile *.muttrc set filetype=muttrc
  au FileType muttrc setlocal foldmethod=marker foldmarker={{{,}}}
augroup END

augroup ft_mail
  au!
  au Filetype mail setlocal spell
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
  au FileType markdown let b:vimpipe_command="multimarkdown"
  au FileType markdown let b:vimpipe_filetype="html"
augroup END

augroup ft_tmux
  au!
  au BufNewFile,BufRead .tmux.conf,tmux.conf* setlocal filetype=tmux
  au BufNewFile,BufRead .tmux.conf,tmux.conf* setlocal commentstring=#\ %s
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
  au FileType ruby let b:vimpipe_command='ruby <(cat)'
augroup END

augroup ft_lua
  au!
  au FileType lua let b:vimpipe_command='lua -lluarocks.loader <(cat)'
augroup END

augroup ft_go
  au!
  au FileType godoc wincmd L | nnoremap <buffer> <silent> K :q<cr>
  au FileType go let b:vimpipe_command='go run %'
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
" Visual Mode */# from Scrooloose {{{1

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" }}}1
" Populate the argument list from the quickfix {{{1

function! s:QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
command! -nargs=0 -bar Qargs execute 'args' s:QuickfixFilenames()

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
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" }}}2
" Gundo {{{2

let g:gundo_help = 0
let g:gundo_preview_bottom = 1

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
" UltiSnips {{{2

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-c>"
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetsDir = "~/.vim/snippets"

" }}}2
" Switch {{{2

let g:switch_custom =
      \ {
      \   'dot_notation': {
      \     '\[["'']\(\k\+\)["'']\]': '\.\1',
      \     '\.\(\k\+\)': '[''\1'']'
      \   }
      \ }

" }}}2
" Unite {{{2

call unite#custom_source('file_rec,file,buffer', 'ignore_pattern', '\.git/')
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = 'botright'

function! s:unite_settings()
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <silent> <buffer> <expr> <C-x> unite#do_action('split')
  imap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
  imap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()

" }}}2
" VimFiler {{{2

let g:vimfiler_as_default_explorer = 1

" }}}2

" }}}1
