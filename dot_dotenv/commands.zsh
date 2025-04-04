function brew() { 
  if [ "$1" = "dump" ]; then
    # this commands dumps all the brew packages installed in a Brewfile
    # this requires that ozxide is installed
    local chezmoi_dir=$(chezmoi source-path)
    local current_dir=$(pwd)
    cd $chezmoi_dir
    cd dot_brew
    rm -rf Brewfile
    brew bundle dump
    sed  -i '' '/^vscode/d' Brewfile
    cd $current_dir
  else 
    command brew "$@"
  fi
}

function renew_tokens() {
  zenpie credentials generate --account $1 && zenpie codeartifact token
}

function gpg-no-tty() {
  echo passphrase | gpg --passphrase-fd 0 --batch --no-tty --yes "$@"
}

function live() {
  renew_tokens live > /dev/null 2>&1
}

function dev() {
  renew_tokens dev > /dev/null 2>&1
}

function check_node_version() {
  if [ -f .nvmrc ]; then
    nvm install
    corepack enable
  fi
}

function cd(){
  z "$@"
  check_node_version
}

function update() {
  brew update
  brew upgrade
  brew cleanup
  brew doctor
  brew dump
}

function git() {
  if [ "$1" = "cleanup" ]; then
    git fetch -p && git branch -vv | grep ': gone' | awk '{print $1}' | xargs git branch -D
  else
    command git "$@"
  fi
}
