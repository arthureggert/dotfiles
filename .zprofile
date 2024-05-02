autoload -Uz compinit

eval $(/opt/homebrew/bin/brew shellenv)
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias fuck)"

compinit

