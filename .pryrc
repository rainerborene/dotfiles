Pry.config.editor = "vim"

Pry.config.prompt = proc do |obj, level, _|
  prompt = "\e[1;29m"
  prompt << "#{Rails.version}@" if defined?(Rails) && Rails.respond_to?(:version)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})>\e[0m "
end

Pry.config.exception_handler = proc do |output, exception|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

if defined?(Rails)
  require "rails/console/app"
  require "rails/console/helpers"

  TOPLEVEL_BINDING.eval("self").extend Rails::ConsoleMethods
end

begin
  require "awesome_print"
  Pry.config.print = proc do |output, value|
    Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)
  end
rescue LoadError
  warn "=> Unable to load awesome_print"
end

ActiveRecord::Base.logger = Logger.new(STDOUT) if defined? ActiveRecord::Base
