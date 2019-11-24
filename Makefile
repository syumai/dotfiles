CWD := $(shell pwd)

install:
	cd ~ && \
		ln -s $(CWD)/.zshrc
