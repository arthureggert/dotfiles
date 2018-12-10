export ZSH=/Users/aheggert/.oh-my-zsh

ZSH_THEME="roa"
CASE_SENSITIVE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(
  docker
  git
  common-aliases
  git-flow
  npm
  osx
  zsh-nvm
  zsh-better-npm-completion
  brew
  sdkman
  yarn
)


# User configuration
export VISUAL=vim
export EDITOR="$VISUAL"
export LANG=en_US.UTF-8
export NVM_DIR="$HOME/.nvm"
export GOPATH=/Users/aheggert/go
export PATH=$GOPATH/bin:/usr/local/bin:$PATH
export NVM_DIR=~/.nvm
export SDKMAN_DIR="$HOME/.sdkman"

source $(brew --prefix nvm)/nvm.sh
source $ZSH/oh-my-zsh.sh
source ~/.env

function code {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        local argPath="$1"
        [[ $1 = /* ]] && argPath="$1" || argPath="$PWD/${1#./}"
        open -a "Visual Studio Code" "$argPath"
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s "/Users/aheggert/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/aheggert/.sdkman/bin/sdkman-init.sh"

alias vim='mvim -v'
alias ag='ag --path-to-ignore ~/.ignore'
