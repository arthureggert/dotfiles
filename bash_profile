unset MANPATH
export NPM_PACKAGES=/home/aheggert/.npm-packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH=$PATH:$NPM_PACKAGES/bin
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
