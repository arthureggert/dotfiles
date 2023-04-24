if [[ "$OSTYPE" == "darwin"* ]] && [[ -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  export ZSH_TMUX_AUTOSTART=true
  export DISABLE_AUTO_TITLE=true
fi

source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle docker
antigen bundle gradle
antigen bundle iterm2
antigen bundle macos
antigen bundle python
antigen bundle sdk
antigen bundle command-not-found
antigen bundle tmux

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# NVM bundle
antigen bundle lukechilds/zsh-nvm

# Gradle Autocomplete
antigen bundle gradle/gradle-completion --branch=master

# Load the theme.
# antigen theme dracula/zsh dracula


# Tell Antigen that you're done.
antigen apply

# alias vim='/opt/homebrew/bin/vim'

ZSH_THEME="dracula-pro"

# NVM
nvm use stable &> /dev/null

# Cycle through history based on characters already typed on the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Load private szh files
local __filename=~/.zshrc
local __filename=${__filename:A}
local __dirname=$(dirname $__filename)

for file in $(find $__dirname/scripts -type f -name '*.zsh'); do
  source $file
done

[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh" # This loads SDKMAN

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -s "/home/aheggert/.antigen/bundles/dracula/zsh/dracula.zsh-theme" ] && source "/home/aheggert/.antigen/bundles/dracula/zsh/dracula.zsh-theme"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(tmuxifier init -)"

eval "$(pyenv init --path)"

eval "$(zoxide init zsh)"

eval "$(thefuck --alias fuck)"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
