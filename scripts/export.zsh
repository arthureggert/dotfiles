#!/usr/bin/env zsh

export GH_TOKEN=$privateGitHubToken
export GITHUB_TOKEN=$privateGitHubToken
export GITHUB_NPM_TOKEN=$privateGitHubToken

if [[ "$OSTYPE" == "darwin"* ]]; then
#    export TERM=xterm-256color-italic
#    export TERMINFO=/usr/share/terminfo
    export COLOR=true
    export FORCE_COLOR=true
    export EDITOR='vim'
    export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.local/bin:$PATH"
#    export LDFLAGS="-L/usr/local/opt/openssl/lib"
#    export CPPFLAGS="-I/usr/local/opt/openssl/include"
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
