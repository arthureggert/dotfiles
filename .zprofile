# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"

if [ -s "/opt/homebrew/bin/brew" ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
else 
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias fuck)"
eval "$(atuin init zsh --disable-up-arrow)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
