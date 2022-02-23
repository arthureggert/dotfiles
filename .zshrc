ZSH_THEME=robbyrussell
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(git docker gradle iterm2 macos python sdk)

alias reload="source ~/.zshrc"

export EDITOR='vim'
export ZSH="/Users/aheggert/.oh-my-zsh"
export SDKMAN_DIR="/Users/aheggert/.sdkman"
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.local/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.commands.sh ] && source ~/.commands.sh
[ -f ~/.env ] && source ~/.env

[ -s "/Users/aheggert/.sdkman/bin/sdkman-init.sh" ] && source "/Users/aheggert/.sdkman/bin/sdkman-init.sh"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(pyenv init -)"
