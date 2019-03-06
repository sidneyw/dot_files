#!/bin/bash
set -x

# Quick install script for mac

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Brew install all packages
brew upgrade

brew install \
	pyenv \
	pyenv-virtualenv \
	nvm \
	go \
	autojump \
	fzf \
	git \
	htop \
	neovim \
	ripgrep \
	the_silver_searcher \
	tmux

$(brew --prefix)/opt/fzf/install

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

if [[ -d $HOME/bin ]]
then
	echo User level bin already exists
else
	ln -s $DOT_FILES/shell/bin ~/bin
	ln -s $DOT_FILES/shell/local_bin ~/local_bin
fi

# Install Fonts

declare -a fonts=("Black/complete/Sauce%20Code%20Pro%20Black%20Nerd%20Font%20Complete%20Mono.ttf"
	"Bold/complete/Sauce%20Code%20Pro%20Bold%20Nerd%20Font%20Complete%20Mono.ttf"
	"Regular/complete/Sauce%21Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf"
	"Medium/complete/Sauce%20Code%20Pro%20Medium%20Nerd%20Font%20Complete%20Mono.ttf"
	"Light/complete/Sauce%20Code%20Pro%20Light%20Nerd%20Font%20Complete%20Mono.ttf"
	)

mkdir -p "$DOT_FILES/fonts"

cd "$DOT_FILES/fonts"

for font_path in "${fonts[@]}"
do
	curl \
		-H 'Accept: application/vnd.github.v3.raw' \
		-O \
		-L "https://api.github.com/repos/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/$font_path"
done

mkdir -p "$HOME/Library/Fonts"

cp *.ttf "$HOME/Library/Fonts"

cd $DOT_FILES

rm -rf "$DOT_FILES/fonts"

# Install Python 3.6.8
pyenv install 3.6.8
pyenv virtualenv 3.6.8 workspace
pyenv activate workspace

# Set up go mono repo
mkdir -p "$HOME/go/bin"
mkdir -p "$HOME/go/pkg"
mkdir -p "$HOME/go/src"

# Install Vim Plugins
pip install pynvim
nvim +PlugInstall +GoInstallBinaries +qa

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
