Rnavcommand admin app/admin -suffix=.rb -default=dashboard
Rnavcommand job app/jobs -suffix=.rb
Rnavcommand uploader app/uploaders -suffix=.rb
Rnavcommand validator app/validators -suffix=.rb
Rnavcommand worker app/workers -suffix=.rb

nnoremap <silent> <localleader>M :call VimuxRunCommand("clear; zeus rake db:migrate:redo VERSION=" . matchstr(bufname("%"), '\v\d+') . " db:test:clone")<CR>
