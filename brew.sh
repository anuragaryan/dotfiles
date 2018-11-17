#!/bin/bash

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."

# Brew maintainace
brew update && brew cleanup

brew install gcc
brew install git
brew install diff-so-fancy
brew install gpg
brew install openssh
brew install tmux
brew install go
brew install node

# Cli tools
brew install tree
brew install wget
brew install nmap

# zsh and oh-my-zsh
brew install zsh
ruby -e "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Brew maintainace
brew update && brew outdated

# Cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

exit 0
