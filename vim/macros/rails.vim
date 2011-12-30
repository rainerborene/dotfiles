command! -nargs=0 Rroutes :1R routes.rb
command! -nargs=0 RSroutes :1RSroutes.rb

command! -nargs=0 Rschema :1R db/schema.rb
command! -nargs=0 RSschema :1RSdb/schema.rb

command! -nargs=0 Rconfig :1R application.rb
command! -nargs=0 RSconfig :1RS application.rb

Rnavcommand admin app/admin -suffix=.rb -default=dashboards
