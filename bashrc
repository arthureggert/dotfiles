#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#SHELL COLORS#
BLACK="\[\033[0;30m\]"
BLACKBOLD="\[\033[1;30m\]"
RED="\[\033[0;31m\]"
REDBOLD="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
GREENBOLD="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
YELLOWBOLD="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
BLUEBOLD="\[\033[1;34m\]"
PURPLE="\[\033[0;35m\]"
PURPLEBOLD="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
CYANBOLD="\[\033[1;36m\]"
WHITE="\[\033[0;37m\]"
WHITEBOLD="\[\033[1;37m\]"
RESET="\[\017\]"
NORMAL="\[\033[0m\]"

#SHELL OPTIONS#
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dirspell
shopt -s expand_aliases
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s dotglob

#ALIAS#
alias ls='ls --color=auto -lai'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias services='service --status-all'
alias lsmnt='lsblk'
alias tree='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias update_system='sudo pacman -Syyu'
alias update_aur='yaourt -Syu --aur'
alias apm="/c/Users/aheggert/AppData/Local/atom/bin/apm"
alias npp="/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe"
alias protractor="/c/Users/aheggert/AppData/Roaming/npm/protractor"

#FUNCTIONS#
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

set_bash_prompt(){
	PS1="${GREEN}\u${GREENBOLD}@\h:${REDBOLD}[${RED}\W$(git_color)$(parse_git_branch)${REDBOLD}]${CYAN}\$ ${YELLOW}~> ${WHITE}"
}

git_update() {
	branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
	remote=$(git remote)
	git pull "$remote" "$branch"
}

git_update_all(){
	currentdir=`pwd`
	cd $1 > /dev/null
	for file in */ ; do 
	  if [[ -d "$file" && ! -L "$file" ]]; then
		if [ -d "$file/.git" ]; then
			cd $file > /dev/null
			echo `pwd`
			git_update()
			cd ..  > /dev/null
		fi
	  fi 
	done
	cd $currentdir > /dev/null
}

#PS1#
PROMPT_COMMAND=set_bash_prompt
#PS1_LINUX='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#PS1_ORIGINAL -> PS1='\u@\h [\W]\$ '

source ~/.profile
