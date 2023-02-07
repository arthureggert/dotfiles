#!/usr/bin/env zsh

export GH_TOKEN=$privateGitHubToken
export GITHUB_TOKEN=$privateGitHubToken
export GITHUB_NPM_TOKEN=$privateGitHubToken

if [[ "$OSTYPE" == "darwin"* ]]; then
    export RUBY_HOME="~/.gem/ruby/2.6.0/bin/"
    export COLOR=true
    export FORCE_COLOR=true
    export EDITOR='vim'
    export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.local/bin:$RUBY_HOME:$PATH"
    export SDKMAN_DIR="$HOME/.sdkman"
    export NVM_DIR="$HOME/.nvm"
    export NVM_AUTO_USE=true
    export NVM_COMPLETION=true
    export NVM_NO_USE=true
    export NVM_SYMLINK_CURRENT=true
    export GPG_TTY=$(tty)
else
    export PATH="$HOME/.local/bin:$PATH"
fi
