project := test-dotfiles-ansible

build:
	docker build -t $(project):latest ansible

shell:
	docker run --rm -it \
		-v $(shell pwd):/home/mfrata/.dotfiles \
		$(project) \
			bash -c "cd ansible/ && ../bin/install && bash"
