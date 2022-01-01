.PHONY: install
install:
	make link

.PHONY: rm
rm:
	rm -rf ~/.vimrc
	rm -rf ~/.zshrc
	rm -rf ~/.tmux.conf
	rm -rf ~/.gitconfig
	rm -rf ~/.config/nvim
	rm -rf ~/.config/alacritty

.PHONY: link
link:
	ln -fs ~/.dotfiles/vimrc ~/.vimrc
	ln -fs ~/.dotfiles/zshrc ~/.zshrc
	ln -fs ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
	ln -fs ~/.dotfiles/gitconfig ~/.gitconfig
	ln -fs ~/.dotfiles/config/nvim ~/.config/nvim
	ln -fs ~/.dotfiles/config/alacritty ~/.config/alacritty
