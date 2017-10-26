#GIT

git_rola() {
  if "$(is_clean)"; then
    echo -e '1';
  else 
    echo -e '2'; 
  fi
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
  currentdir=`pwd`
	cd $1 > /dev/null
	for file in */ ; do
	  if [[ -d "$file" && ! -L "$file" ]]; then
		  if [ -d "$file/.git" ]; then
			  cd $file > /dev/null
        echo -e "\033[0;32m" `basename $file` " \033[0;37m ------------>" "$(git_color_bash)$(git_branch_name)"
			  cd ..  > /dev/null
		  fi
	  fi
	done
	cd $currentdir > /dev/null
}

git_fetch_all() {
  currentdir=`pwd`
	echo $currentdir
	cd $1 > /dev/null
	for file in */ ; do
	  if [[ -d "$file" && ! -L "$file" ]]; then
		  if [ -d "$file/.git" ]; then
			  cd $file > /dev/null
			  echo -e "\033[0;32m" `pwd` "\033[0;37m" `git_branch_name`
			  git fetch
			  cd ..  > /dev/null
		  fi
	  fi
	done
	cd $currentdir > /dev/null
}

git_update_all(){
	currentdir=`pwd`
	echo $currentdir
	cd $1 > /dev/null
	for file in */ ; do
	  if [[ -d "$file" && ! -L "$file" ]]; then
		if [ -d "$file/.git" ]; then
			cd $file > /dev/null
			echo -e "\033[0;32m" `pwd` "\033[0;37m" `git_branch_name`
			git_update
			cd ..  > /dev/null
		fi
	  fi
	done
	cd $currentdir > /dev/null
}

git_branch_name(){
	git branch | sed -n -e 's/^\* \(.*\)/\1/p'
}

git_remote_name(){
	git remote
}

git_discard_local() {
	branch=$(git_branch_name)
	remote=$(git_remote_name)
	git reset --hard "$remote"/"$branch"
}

function git_remote {
  # about 'adds remote $GIT_HOSTING:$1 to current repo'
  # group 'git'

  echo "Running: git remote add origin ${GIT_HOSTING}:$1.git"
  git remote add origin $GIT_HOSTING:$1.git
}
  
function git_pub() {
  # about 'publishes current branch to remote origin'
  # group 'git'
  # BRANCH=$(git rev-parse --abbrev-ref HEAD)

  echo "Publishing ${BRANCH} to remote origin"
  git push -u origin $BRANCH
}

function git_revert() {
  # about 'applies changes to HEAD that revert all changes after this commit'
  # group 'git'

  git reset $1
  git reset --soft HEAD@{1}
  git commit -m "Revert to ${1}"
  git reset --hard
}

function is_clean() {
  if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
    return 0;
  fi
  return 1;
}

function git_rollback() {
  # about 'resets the current HEAD to this commit'
  # group 'git'


  function commit_exists() {
    git rev-list --quiet $1
    status=$?
    if [ $status -ne 0 ]; then
      echo "Commit ${1} does not exist"
      kill -INT $$
    fi
  }

  function keep_changes() {
    while true
    do
      read -p "Do you want to keep all changes from rolled back revisions in your working tree? [Y/N]" RESP
      case $RESP
      in
      [yY])
        echo "Rolling back to commit ${1} with unstaged changes"
        git reset $1
        break
        ;;
      [nN])
        echo "Rolling back to commit ${1} with a clean working tree"
        git reset --hard $1
        break
        ;;
      *)
        echo "Please enter Y or N"
      esac
    done
  }

  if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    is_clean
    commit_exists $1

    while true
    do
      read -p "WARNING: This will change your history and move the current HEAD back to commit ${1}, continue? [Y/N]" RESP
      case $RESP
        in
        [yY])
          keep_changes $1
          break
          ;;
        [nN])
          break
          ;;
        *)
          echo "Please enter Y or N"
      esac
    done
  else
    echo "you're currently not in a git repository"
  fi
}

function git_remove_missing_files() {
  # about "git rm's missing files"
  # group 'git'

  git ls-files -d -z | xargs -0 git update-index --remove
}

# Adds files to git's exclude file (same as .gitignore)
function local-ignore() {
  # about 'adds file or path to git exclude file'
  # param '1: file or path fragment to ignore'
  # group 'git'
  echo "$1" >> .git/info/exclude
}

# get a quick overview for your git repo
function git_info() {
    # about 'overview for your git repo'
    # group 'git'

    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        # print informations
        echo "git repo overview"
        echo "-----------------"
        echo

        # print all remotes and thier details
        for remote in $(git remote show); do
            echo $remote:
            git remote show $remote
            echo
        done

        # print status of working repo
        echo "status:"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
            git status -s
        else
            echo "working directory is clean"
        fi

        # print at least 5 last log entries
        echo
        echo "log:"
        git log -5 --oneline
        echo

    else
        echo "you're currently not in a git repository"

    fi
}

function git_stats {
    # about 'display stats per author'
    # group 'git'

# awesome work from https://github.com/esc/git-stats
# including some modifications

if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    echo "Number of commits per author:"
    git --no-pager shortlog -sn --all
    AUTHORS=$( git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
    LOGOPTS=""
    if [ "$1" == '-w' ]; then
        LOGOPTS="$LOGOPTS -w"
        shift
    fi
    if [ "$1" == '-M' ]; then
        LOGOPTS="$LOGOPTS -M"
        shift
    fi
    if [ "$1" == '-C' ]; then
        LOGOPTS="$LOGOPTS -C --find-copies-harder"
        shift
    fi
    for a in $AUTHORS
    do
        echo '-------------------'
        echo "Statistics for: $a"
        echo -n "Number of files changed: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
        echo -n "Number of lines added: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
        echo -n "Number of lines deleted: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
        echo -n "Number of merges: "
        git log $LOGOPTS --all --merges --author=$a | grep -c '^commit'
    done
else
    echo "you're currently not in a git repository"
fi
}

function gittowork() {
  # about 'Places the latest .gitignore file for a given project type in the current directory, or concatenates onto an existing .gitignore'
  # group 'git'
  # param '1: the language/type of the project, used for determining the contents of the .gitignore file'
  # example '$ gittowork java'

  result=$(curl -L "https://www.gitignore.io/api/$1" 2>/dev/null)

  if [[ $result =~ ERROR ]]; then
    echo "Query '$1' has no match. See a list of possible queries with 'gittowork list'"
  elif [[ $1 = list ]]; then
    echo "$result"
  else
    if [[ -f .gitignore ]]; then
      result=`echo "$result" | grep -v "# Created by http://www.gitignore.io"`
      echo ".gitignore already exists, appending..."
      echo "$result" >> .gitignore
    else
      echo "$result" > .gitignore
    fi
  fi
}

function gitignore-reload() {
  # about 'Empties the git cache, and readds all files not blacklisted by .gitignore'
  # group 'git'
  # example '$ gitignore-reload'

    # The .gitignore file should not be reloaded if there are uncommited changes.
  # Firstly, require a clean work tree. The function require_clean_work_tree()
  # was stolen with love from https://www.spinics.net/lists/git/msg142043.html

  # Begin require_clean_work_tree()

  # Update the index
  git update-index -q --ignore-submodules --refresh
  err=0

  # Disallow unstaged changes in the working tree
  if ! git diff-files --quiet --ignore-submodules --
  then
    echo >&2 "ERROR: Cannot reload .gitignore: Your index contains unstaged changes."
    git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
    err=1
  fi

  # Disallow uncommited changes in the index
  if ! git diff-index --cached --quiet HEAD --ignore-submodules
  then
    echo >&2 "ERROR: Cannot reload .gitignore: Your index contains uncommited changes."
    git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
    err=1
  fi

  # Prompt user to commit or stash changes and exit
  if [ $err = 1 ]
  then
    echo >&2 "Please commit or stash them."
  fi

  # End require_clean_work_tree()

  # If we're here, then there are no uncommited or unstaged changes dangling around.
  # Proceed to reload .gitignore
  if [ $err = 0 ]; then
    # Remove all cached files
    git rm -r --cached .

    # Re-add everything. The changed .gitignore will be picked up here and will exclude the files
    # now blacklisted by .gitignore
    echo >&2 "Running git add ."
    git add .
    echo >&2 "Files readded. Commit your new changes now."
  fi
}
