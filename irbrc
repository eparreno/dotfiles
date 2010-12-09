ARGV.concat ["--prompt-mode", "simple"]


# Disable readline. Useful for latin users
IRB.conf[:USE_READLINE]=false

# Auto-indentation
IRB.conf[:AUTO_INDENT]=true
