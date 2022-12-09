if [ -s "/opt/homebrew/bin/brew" ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
else 
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
