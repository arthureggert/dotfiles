#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'


alias ls='ls --color=auto -lai'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias services='service --status-all'
alias wildfly='cd /opt/wildfly'
alias wildfly-start='/opt/wildfly/bin/standalone.sh'
alias mysql='mysql -u root -p'
alias mysql-start='sudo systemctl start mysqld'
alias lsmnt='lsblk'
alias dotfiles='cd /home/aheggert/Documents/workspace/dotfiles'
alias tmp='cd /home/aheggert/Documents/tmp'
alias tree='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/|/'"'"
alias mysql-start='sudo systemctl start mysqld'
alias php="/opt/lampp/bin/php"
alias htdocs="cd /opt/lampp/htdocs/"
