begin
  require "pry"
  Pry.start
  exit
rescue LoadError
  warn "=> Unable to load pry"
end

Reline::DialogRenderInfo.class_eval do
  def bg_color = 40
  def pointer_bg_color = 41
end if defined? Reline::DialogRenderInfo

def copy(str)
  IO.popen("tmux loadb -", "w") { _1 << str.to_s } unless str.nil?
end
