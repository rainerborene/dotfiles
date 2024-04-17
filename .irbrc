# frozen_string_literal: true

Reline::Face.config(:completion_dialog) do |conf|
  conf.define :default, foreground: :white, background: :black
  conf.define :enhanced, foreground: :white, background: :bright_black
  conf.define :scrollbar, foreground: :blue, background: :bright_black
end

def copy(str)
  IO.popen("win32yank.exe -i", "w") { _1 << str.to_s } unless str.nil?
end
