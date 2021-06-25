function git_prompt_info_no_branch() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2>/dev/null) ||
      ref=$(command git rev-parse --short HEAD 2>/dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}


function nn() {
  NOTE_DIR=~/Box\ Sync/Notes
  NOTE_NAME="$2"
  NOTE_TYPE="$1"
  TIMESTAMP="$(date +%Y-%m-%d)"
  vim "${NOTE_DIR}/${NOTE_TYPE}/${TIMESTAMP}-${NOTE_NAME}.md"
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

function db() {
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

lazy_load() {
    # $1: space separated list of alias to release after the first load
    # $2: file to source
    # $3: name of the command to run after it's loaded
    # $4+: argv to be passed to $3
    echo "Lazy loading $1 ..."

    # $1.split(' ') using the s flag. In bash, this can be simply ($1) #http://unix.stackexchange.com/questions/28854/list-elements-with-spaces-in-zsh
    # Single line won't work: local names=("${(@s: :)${1}}"). Due to http://stackoverflow.com/questions/14917501/local-arrays-in-zsh   (zsh 5.0.8 (x86_64-apple-darwin15.0))
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_color() {
	if git rev-parse --git-dir >/dev/null 2>&1; then
        # check for uncommitted changes in the index
        if ! git diff-index --quiet --cached HEAD --ignore-submodules -- >&2; then
            echo $red
        # check for unstaged changes
        elif ! git diff-files --quiet --ignore-submodules -- >&2; then
            echo $yellow
        else
            echo $green
        fi
    fi
}

git_color_bash() {
	if git rev-parse --git-dir >/dev/null 2>&1; then
        # check for uncommitted changes in the index
        if ! git diff-index --quiet --cached HEAD --ignore-submodules -- >&2; then
            #echo "\[\e[0;31m\]"
            echo "\033[0;31m"
        # check for unstaged changes
        elif ! git diff-files --quiet --ignore-submodules -- >&2; then
            #echo "\[\e[0;33m\]"
            echo "\033[0;33m"
        else
            #echo "\[\e[0;32m\]"
            echo "\033[0;32m"
        fi
    fi
}

git_update() {
	branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
	remote=$(git remote)
	git pull "$remote" "$branch" -q
}

git_status_all() {
	current_dir=$(pwd)
  repos_dir=$HOME/Documents/
  dir_to_check=${1:-$repos_dir}
	cd "$dir_to_check" > /dev/null || exit
	for file in */ ; do
	  if [[ -d "$file" && ! -L "$file" ]]; then
		  if [ -d "$file/.git" ]; then
			  cd "$file" > /dev/null || exit
			  echo -e "\033[0;32m" "$(basename "$file")" " \033[0;37m ------------>" "$(git_color_bash)$(git_branch_name)"
        cd ..  > /dev/null || exit
		  fi
	  fi
	done
	cd "$current_dir" > /dev/null || exit
}

git_update_all(){
  current_dir=$(pwd)
  repos_dir=$HOME/Documents/
  dir_to_check=${1:-$repos_dir}
	cd "$dir_to_check" > /dev/null || exit
	for file in */ ; do
	  if [[ -d "$file" && ! -L "$file" ]]; then
		  if [ -d "$file/.git" ]; then
			  cd "$file" > /dev/null || exit
			  echo -e "\033[0;32m" "$(pwd)" "\033[0;37m" "$(git_branch_name)"
			  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
			  git_update .
        cd ..  > /dev/null || exit
		  fi
	  fi
	done
	cd "$current_dir" > /dev/null || exit
}

git_branch_name(){
	git branch | sed -n -e 's/^\* \(.*\)/\1/p'
}

docker_run() {
  open -a Docker
}

start_communication() {
  open -a Slack
  open -a Whatsapp
  open -a Telegram
}

start_development() {
  repos_dir=$HOME/Documents/
  echo -e "\033[0;32m" "Renewing Zenjob Tokens" "\033[0;37m"
  renew_tokens "$ZENJOB_USERNAME" "$ZENJOB_ENV"
  echo -e "\033[0;32m" "Starting Docker" "\033[0;37m"
  docker_run
  echo -e "\033[0;32m" "Updating all repositories" "\033[0;37m"
  git_update_all "$repos_dir"
  echo -e "\033[0;32m" "Starting Kafka" "\033[0;37m"
  kafka_start
  echo -e "\033[0;32m" "Opening Intellij IDEA" "\033[0;37m"
  idea
  echo -e "\033[0;32m" "Update Brew" "\033[0;37m"
  brew update && brew upgrade
  echo -e "\033[0;32m" "Done" "\033[0;37m"
}

start_day() {
  start_communication
  start_development
}

stop_development() {
  echo -e "\033[0;32m" "Stopping Docker" "\033[0;37m"
  pkill -x Docker
  echo -e "\033[0;32m" "Stopping Kafka" "\033[0;37m"
  kafka_stop > /dev/null
  echo -e "\033[0;32m" "Stopping Intellij IDEA" "\033[0;37m"
  pkill idea
  echo -e "\033[0;32m" "Done" "\033[0;37m"
}

function git_delete_branch() {
  git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}

function reset_idea() {
#https://github.com/PythonicNinja/jetbrains-reset-trial-mac-osx/blob/master/runme.sh

for product in IntelliJIdea WebStorm DataGrip PhpStorm CLion PyCharm GoLand RubyMine Rider; do
  echo "Closing $product"
  ps aux | grep -i MacOs/$product | cut -d " " -f 5 | xargs kill -9

  echo "Resetting trial period for $product"

  echo "removing evaluation key..."
  rm -rf ~/Library/Preferences/$product*/eval

  # Above path not working on latest version. Fixed below
  rm -rf ~/Library/Application\ Support/JetBrains/$product*/eval

  echo "removing all evlsprt properties in options.xml..."
  sed -i '' '/evlsprt/d' ~/Library/Preferences/$product*/options/other.xml

  # Above path not working on latest version. Fixed below
  sed -i '' '/evlsprt/d' ~/Library/Application\ Support/JetBrains/$product*/options/other.xml

  echo
done

echo "removing additional plist files..."
rm -f ~/Library/Preferences/com.apple.java.util.prefs.plist
rm -f ~/Library/Preferences/com.jetbrains.*.plist
rm -f ~/Library/Preferences/jetbrains.*.*.plist

echo "restarting cfprefsd"
killall cfprefsd

echo
echo "That's it, enjoy ;)"

}

group_lazy_load  "/usr/local/opt/nvm/nvm.sh" nvm node npm truffle gulp yarn
