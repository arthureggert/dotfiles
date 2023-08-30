[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"

eval $(/opt/homebrew/bin/brew shellenv)
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias fuck)"

[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
