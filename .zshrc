source ~/.zplug/init.zsh

zplug "dracula/zsh", as:theme

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

zplug load

ZSH_THEME=robbyrussell
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git docker gradle iterm2 osx python vscode yarn zsh-syntax-highlighting zsh-autosuggestions)

alias reload="source ~/.zshrc"

export LANG=en_US.UTF-8
export EDITOR='vim'
export CONFLUENT_HOME="$HOME/.confluent"
export NVM_DIR="$HOME/.nvm"
export TERM="xterm-256color"
export ZSH="/Users/aheggert/.oh-my-zsh"
export SDKMAN_DIR="/Users/aheggert/.sdkman"
export GPG_TTY=$(tty)
export PATH=$(pyenv root)/shims:"/usr/local/opt/libpq/bin:/usr/local/sbin:$CONFLUENT_HOME/bin:$NVM_DIR/versions/node/v12.13.0/bin:$PATH"

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.commands.sh ] && source ~/.commands.sh
[ -f ~/.env ] && source ~/.env
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" --no-use
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
[ -s "/Users/aheggert/.sdkman/bin/sdkman-init.sh" ] && source "/Users/aheggert/.sdkman/bin/sdkman-init.sh"

gpgconf --launch gpg-agent

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
