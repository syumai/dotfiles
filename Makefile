CWD := $(shell pwd)

install:
	cd ~ && \
		ln -s $(CWD)/.zshrc && \
		ln -s $(CWD)/.gitignore_global
