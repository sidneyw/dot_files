install:
	./set-defaults.sh
	./create-symlinks.sh
	./install.sh

sync-brew:
	brew bundle dump --force --file=./Brewfile
