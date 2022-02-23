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

function kafka_start() {
  confluent local services start
  if [ $? -eq 0 ]; then
    echo Kafka on localhost:9092
    echo Zookeeper on localhost:2181
    echo Schema registry on localhost:8081
    echo Control Center UI on http://localhost:9021
  else
    confluent local current | xargs rm -rf
  fi
}

function kafka_stop() {
  confluent local services stop
  if [ $? -eq 0 ]; then
    confluent local current | xargs rm -rf
  fi
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

function git_delete_branch() {
  git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}
