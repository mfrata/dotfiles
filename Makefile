build:
	docker build -t test-ubuntu:latest .

check:
	docker run --rm -it -v $(shell pwd):/home/mfrata/.dotfiles test-ubuntu:latest bash
