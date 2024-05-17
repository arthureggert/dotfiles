# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

export ZSH_TMUX_AUTOSTART=true

if [[ "$OSTYPE" == "darwin"* ]] && [[ -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  export DISABLE_AUTO_TITLE=false
  export ZSH_TMUX_AUTOSTART=false
fi

[ -s "/opt/homebrew/opt/antidote/share/antidote/antidote.zsh" ] && source "/opt/homebrew/opt/antidote/share/antidote/antidote.zsh"

source <(antidote init)

antidote bundle ohmyzsh/ohmyzsh path:lib
antidote bundle ohmyzsh/ohmyzsh path:plugins/git
antidote bundle ohmyzsh/ohmyzsh path:plugins/gradle
antidote bundle ohmyzsh/ohmyzsh path:plugins/macos
antidote bundle ohmyzsh/ohmyzsh path:plugins/python
antidote bundle ohmyzsh/ohmyzsh path:plugins/sdk
antidote bundle ohmyzsh/ohmyzsh path:plugins/command-not-found
antidote bundle ohmyzsh/ohmyzsh path:plugins/pyenv
antidote bundle ohmyzsh/ohmyzsh path:plugins/aws
antidote bundle ohmyzsh/ohmyzsh path:plugins/brew
antidote bundle ohmyzsh/ohmyzsh path:plugins/tmux
antidote bundle ohmyzsh/ohmyzsh path:plugins/colored-man-pages
antidote bundle ohmyzsh/ohmyzsh path:plugins/docker-compose
antidote bundle ohmyzsh/ohmyzsh path:plugins/docker-machine

antidote bundle zsh-users/zsh-completions
antidote bundle zsh-users/zsh-autosuggestions
antidote bundle zsh-users/zsh-syntax-highlighting
antidote bundle lukechilds/zsh-nvm
antidote bundle gradle/gradle-completion
# antidote bundle spaceship-prompt/spaceship-prompt

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

[ -s "$HOMEBREW_HOME/virtualenvwrapper/bin/virtualenvwrapper.sh" ] && source "$HOMEBREW_HOME/virtualenvwrapper/bin/virtualenvwrapper.sh"

[ -s "$HOMEBREW_HOME/chruby/share/chruby/chruby.sh" ] && source "$HOMEBREW_HOME/chruby/share/chruby/chruby.sh"

[ -s "$HOMEBREW_HOME/chruby/share/chruby/auto.sh" ] && source "$HOMEBREW_HOME/chruby/share/chruby/auto.sh"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

eval "$(starship init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
