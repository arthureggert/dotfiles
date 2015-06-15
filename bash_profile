#
# ~/.bash_profile
#
export GRADLE_HOME=/opt/gradle/bin
export M2_HOME=/opt/maven
export M2=$M2_HOME/bin
export GOPATH=/home/aheggert/.go
export SCRIPTS=/home/aheggert/Documents/workspace/dotfiles/scripts
export JAVA_HOME=/usr/lib/jvm/java-8-jdk

export PATH=$PATH:$GRADLE_HOME:$M2:$GOPATH/bin:$SCRIPTS:$JAVA_HOME


[[ -f ~/.bashrc ]] && . ~/.bashrc

