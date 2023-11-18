install:
	./create_symlinks.sh
	./install.sh

sync-brew:
	brew bundle dump --force --file=./Brewfile
