#!/bin/sh

# Welcome to my ci macbook setup script!
# Be prepared to turn your macbook
# into an awesome xcode ci machine in minutes.
#
# Author  : Thomas Kausch
# Date    : 2-11-2017
#

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT


# Setup bin directory in home
if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

# Extend path
export PATH="/usr/local/bin:$PATH" 

# Install XCode command line Tools
if ! xcode-select -p > /dev/null; then  
  xcode-select --install
fi

# Setup Homebrew 
HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

# check if brew has to be installed
if ! command -v brew >/dev/null; then
  echo "Installing Homebrew ..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew doctor


# Uninstall old cask 
if brew list | grep -Fq brew-cask; then
  echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

# Update homebrew
echo "Updating Homebrew formulae ..."
brew update

# Add homebrew casck
brew tap caskroom/cask

# Install unix tools
brew install openssl
brew install libyaml

# Common developer tools
brew cask install sourcetree
brew cask install sublime


# Java development
if [ ! -d "$HOME/Java/" ]; then
  mkdir "$HOME/Java"
fi
brew cask install java

brew install gradle
brew install maven

# Install rbenv and ruby environments
brew install rbenv
cd ~
rbenv init

# fastlane requires XCode CLI Tools (https://developer.apple.com/download/more/)
# sudo gem install fastlane -NV




