#!/bin/bash

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew cask packages..."

# Cask maintainace
brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup

# Install native apps
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Apps I use often
# Brew cask install spectacle
brew cask install vscode
brew cask install skype
brew cask install postman
brew cask install slack

# Dev
brew cask install iterm2
brew cask install sublime-text
brew cask install go


# Container life
brew cask install docker

# Google stuff
echo "Installing Google stuff...."
brew cask install google-chrome

# Messaging and Teams
brew cask install slack

# Browsers
brew cask install brave

# Torrent Clients
brew cask install bittorrent-sync

# Miscellaneous
brew cask install vlc

# Cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

exit 0
