#!/bin/bash

# Welcome to my macbook setup script!
# Be prepared to turn your macbook
# into an awesome development machine in minutes.
#
# Author  : Thomas Kausch
# Date    : 9-3-2017
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

# Image manimpulsation
brew cask install gimp
brew install imagemagick

# Network tools
brew cask install wireshark

# Common browsers
brew cask install google-chrome
brew cask install firefox
brew cask install opera

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
brew install ant

brew install tomcat
brew install jboss-as

brew cask install intellij-idea-ce

# Cotline development
brew install kotlin

# Go dedvelopment 
if [ ! -d "$HOME/Go/" ]; then
  mkdir "$HOME/Go"
fi
brew install go

# Python development
brew install python
brew install python3

if [ ! -d "$HOME/Envs/" ]; then
  mkdir "$HOME/Envs"
fi
pip install virtualenv
pip install virtualenvwrapper
brew cask install pycharm-ce

# JS Development
brew install node
npm update -g npm
npm install -g grunt-cli
brew cask install webstorm


# Test tools
brew cask install mocksmtp



# Games
brew cask install chessx

# Redis Database
brew cask install rdm



