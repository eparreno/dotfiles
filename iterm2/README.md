## Insatallation

Download from https://iterm2.com/downloads/stable/latest

Or with Homebrew `brew install --cask iterm2`


## Sync Configs

````
# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2/settings"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
````
