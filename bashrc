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
	PS1="${GREEN}\u${GREENBOLD}@$\h:${REDBOLD}[${RED}\W$(git_color)$(parse_git_branch)${REDBOLD}]${CYAN}\$ ${YELLOW}~> ${WHITE}"
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

assignProxy(){
   PROXY_ENV="http_proxy ftp_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY"
   for envar in $PROXY_ENV
   do
     export $envar=$1
   done
   for envar in "no_proxy NO_PROXY"
   do
      export $envar=$2
   done
}

clrProxy(){
   assignProxy "" # This is what 'unset' does.
}

myProxy(){
   user=aheggert
   read -p "Password: " -s pass &&  echo -e " "
   proxy_value="http://$user:$pass@192.168.254.254:3128"
   no_proxy_value="localhost,127.0.0.1,LocalAddress,LocalDomain.com"
   assignProxy $proxy_value $no_proxy_value
}

#PS1#
PROMPT_COMMAND=set_bash_prompt
#PS1_LINUX='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#PS1_ORIGINAL -> PS1='\u@\h [\W]\$ '

source ~/.profile
