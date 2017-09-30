#!/bin/bash
# Creates symlinks for dotfiles

dir="$HOME/.dot_files"

echo "Dot files folder: $dir"

ln -s $dir/tmux/tmux.conf $HOME/.tmux.conf
ln -s $dir/tmux/tmux.conf.local $HOME/.tmux.conf.local

ln -s $dir/nvim $HOME/.config/nvim
ln -s $dir/bash_profile $HOME/.bash_profile

ln -s $dir/vim/vimrc $HOME/.vimrc
ln -s $dir/vim $HOME/.vim

ln -s $dir/gitconfig $HOME/.gitconfig
ln -s $dir/gitignore $HOME/.gitignore

if [[ -d $HOME/bin ]]
then
	echo User level bin already exists
else
	ln -s $dir/bin ~/bin
fi
