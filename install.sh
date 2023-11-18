#!/bin/bash
set -x

# Quick install script for mac

DOT_FILES="$HOME/.dot_files"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Brew Packages from Brewfile
brew bundle --file="$DOT_FILES/Brewfile"
$(brew --prefix)/opt/fzf/install

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Install Node
nvm install --lts
nvm use --lts

# Install Python via pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"


export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VERSION=3.10.2
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

pyenv install 3
pyenv virtualenv 3 workspace
pyenv activate workspace

# Set up go mono repo
mkdir -p "$HOME/go"
mkdir -p "$HOME/go/bin"
mkdir -p "$HOME/go/pkg"
mkdir -p "$HOME/go/src"

# Install Vim Plugins
pip install pynvim

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

# Shorten the window resize animation time
defaults write -g NSWindowResizeTime -float 0.003

killall SystemUIServer

# Manual Installs
open -na "Google Chrome" --args --new-window \
	https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro \
	https://www.alfredapp.com/ \
	https://www.spectacleapp.com/
