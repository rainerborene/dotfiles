command! -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden', {
    \ 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all',
    \ 'down': '10%'
    \ })
