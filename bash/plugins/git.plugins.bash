#GIT
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_color() {
	if git rev-parse --git-dir >/dev/null 2>&1; then
        # check for uncommitted changes in the index
        if ! git diff-index --quiet --cached HEAD --ignore-submodules -- >&2; then
            echo $RED
        # check for unstaged changes
        elif ! git diff-files --quiet --ignore-submodules -- >&2; then
            echo $YELLOW
        else
            echo $GREEN
        fi
    fi
}

git_update() {
	branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
	remote=$(git remote)
	git pull "$remote" "$branch"
}

git_update_all(){
	currentdir=`pwd`
	echo $currentdir
	cd $1 > /dev/null
	for file in */ ; do 
	  if [[ -d "$file" && ! -L "$file" ]]; then
		if [ -d "$file/.git" ]; then
			cd $file > /dev/null
			echo -e "\033[0;32m" `pwd` "\033[0;37m"
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