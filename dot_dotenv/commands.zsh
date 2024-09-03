function renew_tokens() {
  workon zenjob && toolbelt credentials.generate -u $1 -a $2 && toolbelt codeartifact.token && export AWS_PROFILE=terraform
}

function db() {
  export AWS_PROFILE=terraform
  echo "$AWS_PROFILE"
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
