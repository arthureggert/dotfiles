function git_prompt_info_no_branch() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2>/dev/null) ||
      ref=$(command git rev-parse --short HEAD 2>/dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

function git_fetch() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

function nn() {
  NOTE_DIR=~/Box\ Sync/Notes
  NOTE_NAME="$2"
  NOTE_TYPE="$1"
  TIMESTAMP="$(date +%Y-%m-%d)"
  vim "${NOTE_DIR}/${NOTE_TYPE}/${TIMESTAMP}-${NOTE_NAME}.md"
}

function renew_tokens() {
  toolbelt credentials.generate -u $1 -a $2 && toolbelt codeartifact.token
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

function git_del_branches() {
  ~/Documents/dotfiles/delete_old_branch.sh .
}

function git_reset_destroy() {
  git reset --hard HEAD~1
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
