function brew_dump() {
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
}

function renew_tokens() {
  workon zenjob && toolbelt credentials.generate -u $1 -a $2 && toolbelt codeartifact.token && export AWS_PROFILE=terraform
}

function db() {
  export AWS_PROFILE=terraform
  i=1
  services=()
  if [ -z "$1" ]; then
    while IFS= read -r line; do
      services+=("$line")
    done < <(toolbelt database.list -p $AWS_PROFILE)
  else
    while IFS= read -r line; do
      services+=("$line")
    done < <(toolbelt database.list -p $AWS_PROFILE | grep $1)
  fi
  for service in "${services[@]}"; do
    echo "[$i] $service"
    ((i++))
  done
  echo "Select DB"
  read selected
  selected_db="${services[$selected]}"
  echo "toolbelt database.connection $selected_db"
  toolbelt database.connection $selected_db -p $AWS_PROFILE
}


function gpg-no-tty() {
  echo passphrase | gpg --passphrase-fd 0 --batch --no-tty --yes "$@"
}

function live() {
  workon zenjob && renew_tokens $COMPANY_USER_NAME live > /dev/null 2>&1
}

function dev() {
  workon zenjob && renew_tokens $COMPANY_USER_NAME dev > /dev/null 2>&1
}
