# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"

export ZSH_TMUX_AUTOSTART=false

if [[ "$OSTYPE" == "darwin"* ]] && [[ -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  export ZSH_TMUX_AUTOSTART=false
  export DISABLE_AUTO_TITLE=false
fi

[ -s "~/.antigen/antigen.zsh" ] && source "~/.antigen/antigen.zsh"
[ -s "/opt/homebrew/share/antigen/antigen.zsh" ] && source "/opt/homebrew/share/antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle docker
antigen bundle gradle
antigen bundle macos
antigen bundle python
antigen bundle sdk
antigen bundle command-not-found
antigen bundle tmux
antigen bundle pyenv

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# NVM bundle
antigen bundle lukechilds/zsh-nvm

# Gradle Autocomplete
antigen bundle gradle/gradle-completion

# Tell Antigen that you're done.
antigen apply

# NVM
nvm use stable &> /dev/null

# Cycle through history based on characters already typed on the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U promptinit

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

[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# [ -s "$HOMEBREW_HOME/spaceship/spaceship.zsh" ] && source "$HOMEBREW_HOME/spaceship/spaceship.zsh" 

[ -s "$HOMEBREW_HOME/virtualenvwrapper/bin/virtualenvwrapper.sh" ] && source "$HOMEBREW_HOME/virtualenvwrapper/bin/virtualenvwrapper.sh"

[ -s "$HOMEBREW_HOME/chruby/share/chruby/chruby.sh" ] && source "$HOMEBREW_HOME/chruby/share/chruby/chruby.sh"

[ -s "$HOMEBREW_HOME/chruby/share/chruby/auto.sh" ] && source "$HOMEBREW_HOME/chruby/share/chruby/auto.sh"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

eval "$(atuin init zsh --disable-up-arrow)"

eval "$(starship init zsh)"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
