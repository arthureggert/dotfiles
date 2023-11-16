#!/usr/bin/env zsh

#
## Sync Homebrew installations between Macs via Dropbox
#

BREW="/opt/homebrew/bin/brew"

# first get local settings
echo "Reading local settings ..."
rm -f /tmp/brew-sync.* >/dev/null
$BREW tap > /tmp/brew-sync.taps
$BREW list  --formulae > /tmp/brew-sync.installed
$BREW list --cask -1 > /tmp/brew-sync.casks

# then combine it with list in Dropbox
echo "Reading settings from Dropbox ..."
[ -e ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.taps ] && cat ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.taps >> /tmp/brew-sync.taps
[ -e ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.installed ] && cat ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.installed >> /tmp/brew-sync.installed
[ -e ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.casks ] && cat ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.casks >> /tmp/brew-sync.casks

# make the lists unique and sync into Dropbox
echo "Syncing to iCloud..."
cat /tmp/brew-sync.taps | sort | uniq > ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.taps
cat /tmp/brew-sync.installed | sort | uniq > ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.installed
cat /tmp/brew-sync.casks | sort | uniq > ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.casks

# Set taps
echo "Enabling taps ..."
for TAP in `cat ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.taps`; do
	$BREW tap ${TAP} >/dev/null
done

# Install missing Homebrew packages
echo "Install missing packages ..."
for PACKAGE in `cat ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.installed`; do
	$BREW list ${PACKAGE} >/dev/null
	[ "$?" != "0" ] && $BREW install ${PACKAGE}
done

echo "Install missing casks ..."
for CASK in `cat ~/Library/Mobile\ Documents/com~apple~CloudDocs/Homebrew/brew-sync.casks`; do
	$BREW list --cask -1 ${CASK} >/dev/null
	[ "$?" != "0" ] && $BREW install --cask ${CASK}
done
