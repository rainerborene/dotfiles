command! -nargs=0 Rroutes :1R routes.rb
command! -nargs=0 RSroutes :1RS routes.rb

command! -nargs=0 Rseeds :1R db/seeds.rb
command! -nargs=0 RSseeds :1RS db/seeds.rb

command! -nargs=0 Rschema :1R db/schema.rb
command! -nargs=0 RSschema :1RS db/schema.rb

command! -nargs=0 Rconfig :1R application.rb
command! -nargs=0 RSconfig :1RS application.rb

Rnavcommand admin app/admin -suffix=.rb -default=dashboards
