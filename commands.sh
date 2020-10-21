function git_prompt_info_no_branch() {
    local ref
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

function git_fetch() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}

function nn() {
    NOTE_DIR=~/Box\ Sync/Notes
    NOTE_NAME="$2"
    NOTE_TYPE="$1"
    TIMESTAMP="$(date +%Y-%m-%d)"
    vim "${NOTE_DIR}/${NOTE_TYPE}/${TIMESTAMP}-${NOTE_NAME}.md"
}

function renew_tokens() {
    toolbelt credentials.generate -u $1 -a $2 && toolbelt codeartifact.token
}

function pwcopy() {
  < /dev/urandom \
    LC_CTYPE=C \
    tr -dc a-zA-Z0-9 \
    | head -c ${1:-16} \
    | pbcopy \
    && pbpaste \
    && echo
}
