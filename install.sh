#!/bin/bash
set -x

# Creates symlinks for dotfiles
DOT_FILES="$HOME/.dot_files"

echo "Dot files folder: $DOT_FILES"

ln -s $DOT_FILES/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOT_FILES/tmux/tmux.conf.local $HOME/.tmux.conf.local

ln -s $DOT_FILES/nvim $HOME/.config/nvim
ln -s $DOT_FILES/shell/bash_profile $HOME/.bash_profile

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
