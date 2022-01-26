build:
	docker build -t test-ubuntu:latest ansible

check:
	docker run --rm -it -v $(shell pwd):/home/mfrata/.dotfiles test-ubuntu:latest bash /home/mfrata/.dotfiles/bin/install
