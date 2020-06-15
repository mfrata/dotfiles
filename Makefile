.PHONY: install
install: rm link

.PHONY: rm
rm:
	rm ~/.vimrc
	rm ~/.zshrc
	rm ~/.bash_aliases
	rm ~/.tmux.conf
	rm ~/.gitconfig
	rm ~/.config/nvim/init.vim

.PHONY: link
link:
	ln -s ~/.dotfiles/vimrc ~/.vimrc
	ln -s ~/.dotfiles/zshrc ~/.zshrc
	ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
	ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/gitconfig ~/.gitconfig
	ln -s ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
	ln -s ~/.dotfiles/config/alacritty/alacritty ~/.config/alacritty/alacritty.yml

set_shell:
	echo "export SHELL=/bin/zsh" >> ~/.bashrc
	echo "exec /bin/zsh -l" >> ~/.bashrc
