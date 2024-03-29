#!/usr/bin/env zsh

sudo -v

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

local __dirname=$(dirname ${0:A})

ln -s $__dirname/.zshrc ~/.zshrc
ln -s $__dirname/.zprofile ~/.zprofile
ln -s $__dirname/.wezterm.lua ~/.wezterm.lua
ln -s $__dirname/wezterm ~/.config/wezterm
ln -s $__dirname/lazyvim ~/.config/nvim
ln -s $__dirname/spaceship ~/.config/spaceship
ln -s $__dirname/tmux/.tmux.conf ~/.tmux.conf
ln -s $__dirname/git/.gitconfig ~/.gitconfig

zsh brew/brew.sh
zsh macos/defaults.zsh

if ! [ -s "$NVM_DIR/nvm.sh" ]; then
	echo "Installing NVM"
  	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  	nvm install --lts
fi

if ! [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
	echo "Installing sdkman"
	curl -s "https://get.sdkman.io" | bash
	sdk install java 17.0.2-open
	sdk install java 11.0.14-librca
fi
#
## M1 requirement to install toolbelt
#sudo ln -sfn /opt/homebrew/Cellar/openssl@3/3.0.1 /usr/local/opt/openssl
#
#if ! [ -x "$(command -v toolbelt)" ]; then
#	aws s3 cp $toolbeltUrl ~/pypi-temp/
#	python3 -m pip install ~/pypi-temp/zenjobtoolbelt-latest.tar.gz
#fi
