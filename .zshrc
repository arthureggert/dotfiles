export ZSH=/Users/aheggert/.oh-my-zsh
ZSH_THEME="lambda-gitster"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(
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

source $ZSH/oh-my-zsh.sh

# User configuration
export VISUAL=vim
export EDITOR="$VISUAL"
export LANG=en_US.UTF-8
export NPM_TOKEN="5f81e6ab-0e7a-4be4-8da4-2d23850541b3"
export NVM_DIR="$HOME/.nvm"
export CYPRESS_KEY="1dfd31d6-6db7-4f06-a9dc-e8e156f756ba"
export PATH=/usr/local/bin:$PATH

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


[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export SDKMAN_DIR="/Users/aheggert/.sdkman"
[[ -s "/Users/aheggert/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/aheggert/.sdkman/bin/sdkman-init.sh"

  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship
