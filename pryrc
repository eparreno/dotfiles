begin
  require File.join(Dir.getwd, 'config', 'environment.rb')
rescue LoadError
  puts "No Rails app detected"
end

if defined?(Rails) && Rails.env
  if Rails.version.first == '2'
    require 'console_app'
    require 'console_with_helpers'
  else
    require "rails/console/app"
    require 'rails/console/helpers'
    extend Rails::ConsoleMethods if Rails.version.to_f >= 3.2
  end

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

# Better colors when printing an object
Pry.config.print = proc do |output, value|
  Pry::ColorPrinter.pp(value, output, 65536)
end

# Aliases
# Pry.commands.alias_command 'c', 'continue'
# Pry.commands.alias_command 's', 'step'
# Pry.commands.alias_command 'n', 'next'
# Pry.commands.alias_command 'f',  'finish'
# Pry.commands.alias_command 'ss', 'show-source'
# Pry.config.commands.alias_command 'w', 'whereami'

# Repeat last command when hitting Enter
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.input = StringIO.new(Pry.history.to_a.last)
end

# Prompt
prompt = "\033[1m"
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
