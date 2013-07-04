# It's a Rails app?
begin
  require File.join(Dir.getwd, 'config', 'environment.rb')
rescue LoadError
  puts "No Rails app detected"
end

if defined?(Rails) && Rails.env
  # load rails console helpers
  # you'll be able to use reload! ;)
  require "rails/console/app"
  extend Rails::ConsoleMethods unless Rails.version =~ /3.0/

  # Show SQL info
  if defined?(ActiveRecord)
    require 'logger'
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.clear_active_connections!
  end
end

# Better colors
Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# Prompt
prompt = "\e[1;30m"
#prompt << "#{Rails.version}@" if defined?(Rails)
prompt << "#{RUBY_VERSION}"

Pry.prompt = [
              proc { |obj, level, _| "#{prompt} (#{obj}):#{level} > \e[0m" },
              proc { |obj, level, _| "#{prompt} (#{obj}):#{level} * \e[0m" }
             ]

# vim FTW
Pry.config.editor = "vim"

# Display error messages in red
Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

# Return only the methods not present on basic objects
class Object
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end
end

