WIDTH = 725
HEIGHT = 480
FPS = 31
PLAYER = 8
BGCOLOR = "#ffffff"
APP = "SWFMP3"

require "erb"

def render_template(file)
  filename = File.basename(file).split(".")[0]
  case File.basename(file).split(".")[1]
  when "rhtml"
    extension = "html"
  when "rxml"
    extension = "xml"
  end
  to_file = filename + "." + extension
  puts "Rendering #{file}"
  open(to_file,"w") do |f|
    f << ERB.new(IO.read(file)).result
  end
end

task :compile do
  if @nodebug
    puts "Trace disabled"
    trace = " -trace no"
  else
    trace = ""
  end
  @start = Time.now
  ["*.rhtml","*.rxml"].each do |list|
    Dir[list].each do |tpl|
      render_template(tpl)
    end
  end
  puts %x(swfmill simple #{APP}.xml #{APP}.swf)
  rm "#{APP}.xml"
  puts %x(mtasc -swf #{APP}.swf -main -mx -version #{PLAYER} #{trace} #{APP}.as)
  @end = Time.now

  ["*.html","*.swf"].each do |list|
    Dir[list].each do |file|
      mv file, "deploy/#{file}"
    end
  end
end


task :notify do
  msg = "Finished compiling in #{@end - @start}s."
  if @nodebug
    msg += "\ntrace() disabled"
  end
  %x(growlnotify --name Rake -m '#{msg}' 'Rake')
end


task :nodebug do
  @nodebug = true
end

desc "Test the SWF file in your default browser"
task :test => [:compile] do
  %x(open deploy/index.html)
end


desc "Build a release version of SWFMP3 (with trace() disabled)"
task :release => [:nodebug,:compile,:notify]

task :default => [:compile,:notify,:test]
