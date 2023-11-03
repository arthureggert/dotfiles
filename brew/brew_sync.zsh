#!/usr/bin/env zsh

echo "Enabling taps ..."
for TAP in `cat ~/Dropbox/Apps/Homebrew/brew-sync.taps`; do
	brew tap ${TAP} >/dev/null
done

# Install missing Homebrew packages
echo "Install missing packages ..."
for PACKAGE in `cat ~/Dropbox/Apps/Homebrew/brew-sync.installed`; do
	brew list ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $BREW install ${PACKAGE}
done

echo "Install missing casks ..."
for CASK in `cat ~/Dropbox/Apps/Homebrew/brew-sync.casks`; do
	brew list -1 --cask ${CASK} >/dev/null
	[ "$?" != "0" ] && $BREW cask install ${CASK}
done
