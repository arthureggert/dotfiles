#!/usr/bin/env zsh

export GH_TOKEN=$privateGitHubToken
export GITHUB_TOKEN=$privateGitHubToken
export GITHUB_NPM_TOKEN=$privateGitHubToken

if [[ "$OSTYPE" == "darwin"* ]]; then
    export GOPATH="$HOME/.go"
    export WORKON_HOME="$HOME/.virtualenvs"
    #export RUBY_HOME="~/.gem/ruby/2.6.0/bin/"

    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_PATH="$PYENV_ROOT/bin"

    #export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"

    export TERM="screen-256color"

    export TMUXIFIER_PATH="$HOME/.tmux/plugins/tmuxifier/bin"

    export COLOR=true
    export FORCE_COLOR=true
    export EDITOR='nvim'

    export JETBRAINS_SCRIPT='/Users/aheggert/Library/Application Support/JetBrains/Toolbox/scripts'

    # export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.local/bin:$PYENV_PATH:$RUBY_HOME:$TMUXIFIER_PATH:$JETBRAINS_SCRIPT:$PATH"
    export PATH="/usr/local/bin:/opt/homebrew/bin:$HOME/.local/bin:$PYENV_PATH:$TMUXIFIER_PATH:$JETBRAINS_SCRIPT:$PATH"

    export SDKMAN_DIR="$HOME/.sdkman"

    export NVM_DIR="$HOME/.nvm"
    export NVM_AUTO_USE=true
    export NVM_COMPLETION=true
    export NVM_NO_USE=true
    export NVM_SYMLINK_CURRENT=true

    export GPG_TTY=$(tty)
    
    export HOMEBREW_HOME="/opt/homebrew/opt"

    export PATH="/Users/aheggert/.perl5/bin${PATH:+:${PATH}}:.:$PATH"
    export PERL5LIB="/Users/aheggert/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
    export PERL_LOCAL_LIB_ROOT="/Users/aheggert/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
    export PERL_MB_OPT="--install_base \"/Users/aheggert/.perl5\""
    export PERL_MM_OPT="INSTALL_BASE=/Users/aheggert/.perl5";

    export FZF_CTRL_R_OPTS="--reverse"
    export FZF_TMUX_OPTS="-p"
    export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
else
    export PATH="$HOME/.local/bin:$PATH:$(go env GOPATH)/bin"
fi
