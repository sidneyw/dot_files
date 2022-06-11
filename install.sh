#!/bin/bash
set -x

# Quick install script for mac

# Creates symlinks for dotfiles
DOT_FILES="$HOME/.dot_files"

echo "Dot files folder: $DOT_FILES"

cd $DOT_FILES

ln -s $DOT_FILES/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOT_FILES/tmux/tmux.conf.local $HOME/.tmux.conf.local

ln -s $DOT_FILES/nvim $HOME/.config/nvim
ln -s $DOT_FILES/shell/bash_profile.sh $HOME/.bash_profile

ln -s $DOT_FILES/vim/vimrc $HOME/.vimrc
ln -s $DOT_FILES/vim $HOME/.vim

ln -s $DOT_FILES/git/gitconfig $HOME/.gitconfig
ln -s $DOT_FILES/git/gitignore $HOME/.gitignore

ln -s $DOT_FILES/phoenix/out/phoenix.js $HOME/.phoenix.js

if [[ -d $HOME/bin ]]
then
	echo User level bin already exists
else
	ln -s $DOT_FILES/shell/bin ~/bin
	ln -s $DOT_FILES/shell/local_bin ~/local_bin
fi

$(brew --prefix)/opt/fzf/install

luarocks install luacheck

# Install Node 10
nvm install 10
npm i -g prettier dockerfile-language-server-nodejs bash-language-server

# Install Python

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VERSION=3.10.2
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

pyenv install 3.10.2
pyenv virtualenv 3.10.2 workspace
pyenv activate workspace

# Set up go mono repo
mkdir -p "$HOME/go"
mkdir -p "$HOME/go/bin"
mkdir -p "$HOME/go/pkg"
mkdir -p "$HOME/go/src"

# Install Vim Plugins
pip install pynvim
nvim +PlugInstall +qa

# Increase Key Repeat
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Hide Dock
defaults write com.apple.Dock autohide -bool TRUE
killall Dock

# Show Battery Percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Show Bluetooth and Clock
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

killall SystemUIServer

# Manual Installs

open -na "Google Chrome" --args --new-window \
	https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro \
	https://iterm2colorschemes.com/ \
	https://www.alfredapp.com/ \
	https://www.spectacleapp.com/
