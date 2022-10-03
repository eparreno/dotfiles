# https://github.com/holman/dotfiles
require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do
  dotfiles = Dir.glob('*')
  dotfiles.delete("README.md")
  dotfiles.delete("Rakefile")
  dotfiles.delete("iterm")
  dotfiles.delete("fonts")

  overwrite_all = false
  backup_all = false

  dotfiles.each do |dotfile|
    overwrite = false
    backup = false

    # file = dotfile.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{dotfile}"

    if File.exists?(target) || File.symlink?(target)
      unless overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 's' then next
        end
      end
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    `ln -svf "$PWD/#{dotfile}" "#{target}"`
  end
end

task :default => 'install'
