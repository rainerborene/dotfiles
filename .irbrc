# frozen_string_literal: true

# https://gist.github.com/adamcrown/932231
def require_without_bundler(gem_name)
  if defined?(::Bundler)
    spec_path = Dir.glob("#{Gem.dir}/specifications/#{gem_name}-[0-9]*.gemspec").last
    unless spec_path
      warn "Couldn't find gem '#{gem_name}'"
      return false
    end

    spec = Gem::Specification.load(spec_path)
    spec.runtime_dependencies.each do |dep|
      next if dep.name.include?("irb")
      require_without_bundler(dep.name)
    end

    spec.activate
  end

  require gem_name
  true
rescue LoadError, Gem::MissingSpecError, Gem::LoadError => err
  warn "Couldn't load '#{gem_name}': #{err.message}"
  false
end

require_without_bundler "irb-fzf-history"

IRB::FZF::History.enable!

Reline::Face.config(:completion_dialog) do |conf|
  conf.define :default, foreground: :white, background: :black
  conf.define :enhanced, foreground: :white, background: :bright_black
  conf.define :scrollbar, foreground: :blue, background: :bright_black
end

def cc(str)
  IO.popen("win32yank.exe -i", "w") { _1 << str.to_s } unless str.nil?
end

IRB.conf[:COPY_COMMAND] = "win32yank.exe -i"
