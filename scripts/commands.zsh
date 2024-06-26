#!/usr/bin/env zsh

function apis() {
  atac --directory ~/Documents/apis
}

function back () {
  cd ..
}

function create_docker_separator() {
  defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'; killall Dock
}

function randpw() { 
  LENGTH=${1:-16}
  openssl rand -base64 $LENGTH | pbcopy
}

function update_branches() {
  GIT_DIR=".git"
  for DIR in $(ls -d */); do
    cd ${DIR}
    if [ -d $GIT_DIR ]; then
      delete_old_branch
    fi
    cd ..
  done
}

function renew_tokens() {
  toolbelt credentials.generate -u $1 -a $2 && toolbelt codeartifact.token && export AWS_PROFILE=terraform
}

function pwcopy() {
  LC_CTYPE=C \
    tr </dev/urandom \
    \
    -dc a-zA-Z0-9 |
    head -c ${1:-16} |
    pbcopy &&
    pbpaste &&
    echo
}

function docker_images_prune() {
  docker stop $(docker ps -a -q)
  docker system prune --all --force
}

function docker_container_prune() {
  docker stop $(docker ps -a -q)
  docker container prune --force
}

function docker_kafka() {
  docker compose -f ~/Documents/docker/kafka.yml up -d
}

function docker_pg() {
  docker compose -f ~/Documents/docker/postgres.yml up -d
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

docker_run() {
  open -a Docker
}

function delete_old_branch() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
  #  git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}

function gpg-no-tty() {
  echo passphrase | gpg --passphrase-fd 0 --batch --no-tty --yes "$@"
}

function gradle_install() {
  gradle build -x test
}

function live() {
  workon zenjob && renew_tokens $COMPANY_USER_NAME live > /dev/null 2>&1
}

function dev() {
  workon zenjob && renew_tokens $COMPANY_USER_NAME dev > /dev/null 2>&1
}

