#!/usr/bin/env ruby
# from http://errtheblog.com/posts/89-huba-huba
# See install.sh

home = File.expand_path('~')

Dir['*'].each do |file|
  next if file =~ /install/
  target = File.join(home, ".#{file}")
  unless File.exist? target
    system %[ln -vsf #{File.expand_path file}  #{target}]
  end
end
