#!/usr/bin/env zsh


local __dirname=$(dirname ${0:A})

if which brew &> /dev/null; then
  echo brew: already installed
else
  echo brew: installing
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

local fileLocation=$__dirname/brewfile
local lockLocation=$__dirname/brewfile.lock.json

echo brew: regenerating brewfile lock
rm -rf $lockLocation

echo brew: installing formulas/casks from the brewfile
brew bundle --file=$fileLocation

echo brew: uninstalling formulas/casks not in the brewfile
brew bundle cleanup --file=$fileLocation --force

echo brew: removing unused dependencies
brew autoremove