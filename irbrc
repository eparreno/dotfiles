# !/usr/bin/ruby
#
# Author: Emili Parreno
# http://github.com/eparreno/dotfiles

require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

# history
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb_history')

# Auto-indentation
IRB.conf[:AUTO_INDENT] = true

# Disable readline. Useful for latin users
IRB.conf[:USE_READLINE] = true

# list object methods
def local_methods(obj = self)
  (obj.methods - obj.class.superclass.instance_methods).sort
end

# reload this .irbrc
def reload!
  load __FILE__
end

def ls
  %x{ls}.split("\n")
end

def cd(dir)
  Dir.chdir(dir)
  Dir.pwd
end

def pwd
  Dir.pwd
end

alias p pp
alias q exit
