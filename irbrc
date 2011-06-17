begin
  require 'rubygems'
  require 'wirble' # see http://pablotron.org/software/wirble/ documentation.
  require 'ap'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load library: #{err}"
end

# prompt behavior
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE

# easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end
