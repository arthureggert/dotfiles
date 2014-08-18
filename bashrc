#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dropbox='cd /home/aheggert/Documents/Dropbox'
alias faculdade='cd /home/aheggert/Documents/Dropbox/Faculdade'
alias cg='vim /home/aheggert/Documents/Dropbox/Faculdade/7\ Semestre/cg/aulas.txt'
alias web='vim /home/aheggert/Documents/Dropbox/Faculdade/7\ Semestre/web/aulas.txt'
alias services='service --status-all'
alias workspace='cd /home/aheggert/Documents/workspace'
alias wildfly='cd /opt/wildfly'
alias mysql='mysql -u root -p'
alias lsmnt='lsblk'
alias dotfiles='cd /home/aheggert/Documents/workspace/dotfiles'
alias tmp='cd /home/aheggert/Documents/tmp'
alias tree='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias mysql-start='sudo systemctl start mysqld'
PS1='[\u@\h \W]\$ '
