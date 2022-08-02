.DEFAULT_GOAL = install

# recursive and force
RMFILE := rm -rf

# force and symbolic
LINK := ln -fs

# create intermediary dirs
MKDIR := mkdir -p

CLONE := git clone --quiet https://github.com/$(repo)


.PHONY: rm
rm:
	$(RMFILE) ~/.vimrc
	$(RMFILE) ~/.zshrc
	$(RMFILE) ~/.tmux.conf
	$(RMFILE) ~/.gitconfig
	$(RMFILE) ~/.config/nvim
	$(RMFILE) ~/.config/alacritty

mkdirs:
	$(MKDIR) ~/.config
	$(MKDIR) ~/.zsh

link:
	$(LINK) ~/.dotfiles/vimrc ~/.vimrc
	$(LINK) ~/.dotfiles/zshrc ~/.zshrc
	$(LINK) ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
	$(LINK) ~/.dotfiles/gitconfig ~/.gitconfig
	$(LINK) ~/.dotfiles/config/nvim ~/.config/nvim
	$(LINK) ~/.dotfiles/config/alacritty ~/.config/alacritty


.PHONY: install
install: mkdirs link
	$(CLONE)sindresorhus/pure ~/.zsh/pure
	$(CLONE)ohmyzsh/ohmyzsh ~/.oh-my-zsh
