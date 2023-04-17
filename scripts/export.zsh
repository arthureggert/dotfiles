#!/usr/bin/env zsh

export GH_TOKEN=$privateGitHubToken
export GITHUB_TOKEN=$privateGitHubToken
export GITHUB_NPM_TOKEN=$privateGitHubToken

if [[ "$OSTYPE" == "darwin"* ]]; then
    export TMUXIFIER_PATH="$HOME/.tmux/plugins/tmuxifier/bin"
    export RUBY_HOME="~/.gem/ruby/2.6.0/bin/"
    export COLOR=true
    export FORCE_COLOR=true
    export EDITOR='nvim'
    export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.local/bin:$RUBY_HOME:$TMUXIFIER_PATH:$PATH"
    export SDKMAN_DIR="$HOME/.sdkman"
    export NVM_DIR="$HOME/.nvm"
    export NVM_AUTO_USE=true
    export NVM_COMPLETION=true
    export NVM_NO_USE=true
    export NVM_SYMLINK_CURRENT=true
    export GPG_TTY=$(tty)
    export ZK_NOTEBOOK_DIR="/Users/aheggert/Documents/workbech/"
    export FZF_CTRL_R_OPTS="--reverse"
    export FZF_TMUX_OPTS="-p"
    export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

else
    export PATH="$HOME/.local/bin:$PATH"
fi
