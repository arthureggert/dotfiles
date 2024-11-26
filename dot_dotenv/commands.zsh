function get_db_password() {
  local output=$(toolbelt database.connection $1)
  local access_token=$(echo "$output" | grep -A 1 "Access token (password)" | tail -n 1)
  echo $access_token | pbcopy
  export PGPASSWORD="$access_token"
}

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
  # workon zenjob && toolbelt credentials.generate -u $1 -a $2 && toolbelt codeartifact.token && export AWS_PROFILE=terraform
  zenpie credentials generate --username $1 --account $2 && zenpie codeartifact token
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
  renew_tokens $COMPANY_USER_NAME live > /dev/null 2>&1
}

function dev() {
  renew_tokens $COMPANY_USER_NAME dev > /dev/null 2>&1
}
