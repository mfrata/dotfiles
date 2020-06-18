.PHONY: install
install:
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/nvim
	make link

.PHONY: rm
rm:
	rm ~/.vimrc
	rm ~/.zshrc
	rm ~/.tmux.conf
	rm ~/.gitconfig
	rm ~/.config/nvim/init.vim
	rm ~/.config/alacritty/alacritty.yml

.PHONY: link
link:
	ln -fs ~/.dotfiles/vimrc ~/.vimrc
	ln -fs ~/.dotfiles/zshrc ~/.zshrc
	ln -fs ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
	ln -fs ~/.dotfiles/gitconfig ~/.gitconfig
	ln -fs ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
	ln -fs ~/.dotfiles/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

set_shell:
	echo "export SHELL=/bin/zsh" >> ~/.bashrc
	echo "exec /bin/zsh -l" >> ~/.bashrc
