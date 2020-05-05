#!/bin/sh

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

# Common browsers
brew cask install google-chrome
brew cask install firefox

# Common Microsoft tools
brew cask install microsoft-teams
brew cask install microsoft-outlook
brew cask install skype-for-business

# Common dev tools
brew cask install sourcetree
brew cask install sublime

# iOS dev tools
brew cask install sublime-text 

# Java development
if [ ! -d "$HOME/Java/" ]; then
  mkdir "$HOME/Java"
fi
brew cask install java
brew install gradle
brew install maven
brew install ant

# brew install tomcat
# brew install jboss-as
# brew cask install intellij-idea-ce

# Cotline development
brew install kotlin

# Scala development
brew install scala
brew cask install scala-ide

# Go dedvelopment 
if [ ! -d "$HOME/Go/" ]; then
  mkdir "$HOME/Go"
fi
brew install go --cross-compile-common

# Python development
brew install python3
if [ ! -d "$HOME/Envs/" ]; then
  mkdir "$HOME/Envs"
fi
pip2 install virtualenv
pip2 install virtualenvwrapper
brew cask install pycharm-ce

# JS Development
# brew install node
# vnpm update -g npm
# npm install -g grunt-cli
# brew cask install webstorm

# Cloud foundry
brew tap cloudfoundry/tap
brew install cf-cli

# Games & Fun
brew cask install chessx
brew cask install scratch

# Redis Database
# brew cask install rdm

# tap the science formulae
# brew tap homebrew/science

# install Octave with dependencies
# the update/upgrade command below could take a while
# brew update && brew upgrade
# brew install gcc
# brew cask install xquartz
# install octave
# brew install octave
# brew install fltk
# brew install gnuplot



