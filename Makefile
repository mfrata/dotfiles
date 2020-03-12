.PHONY: install
install: rm link

.PHONY: rm
rm:
	rm ~/.vimrc
	rm ~/.zshrc
	rm ~/.bash_aliases
	rm ~/.tmux.conf
	rm ~/.gitconfig

.PHONY: link
link:
	ln -s ~/.dotfiles/vimrc ~/.vimrc
	ln -s ~/.dotfiles/zshrc ~/.zshrc
	ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
	ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
