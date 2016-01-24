#
# ~/.bash_profile
#
export GRADLE_HOME=/opt/gradle/bin
export M2_HOME=/opt/maven
export M2=$M2_HOME/bin
export GOPATH=/home/aheggert/.go
export SCRIPTS=/home/aheggert/Documents/Workspace/dotfiles/scripts
export JAVA_HOME=/usr/lib/jvm/java-8-jdk
export NPM_PACKAGES=/home/aheggert/.npm-packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

export PATH=$PATH:$GRADLE_HOME:$M2:$GOPATH/bin:$SCRIPTS:$JAVA_HOME:$NPM_PACKAGES/bin

unset MANPATH 
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

[[ -f ~/.bashrc ]] && . ~/.bashrc

