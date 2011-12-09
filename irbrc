require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8

begin
  require 'wirble' 
  require 'interactive_editor'
  require 'awesome_print'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
end

# prompt behavior
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE

# benchmarking helper (http://ozmm.org/posts/time_in_irb.html)
if defined? Benchmark
  def time(times = 1)
    ret = nil
    Benchmark.bm { |x| x.report { times.times { ret = yield } } }
    ret
  end
end

# log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end
