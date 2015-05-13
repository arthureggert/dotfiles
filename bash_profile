#
# ~/.bash_profile
#
export GRADLE_HOME=/opt/gradle/bin
export M2_HOME=/opt/maven
export M2=$M2_HOME/bin
export GOPATH=/home/aheggert/.go
export SCRIPTS=/home/aheggert/Documents/Dropbox/scripts

export PATH=$PATH:$GRADLE_HOME:$M2:$GOPATH/bin:$SCRIPTS


[[ -f ~/.bashrc ]] && . ~/.bashrc

