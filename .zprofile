# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.pre.zsh"
eval $(/opt/homebrew/bin/brew shellenv)
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias fuck)"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/aheggert/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zprofile.post.zsh"
