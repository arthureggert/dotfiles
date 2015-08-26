#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#SHELL COLORS#
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#OLDER -> PS1='\u@\h [\W]\$ '

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
