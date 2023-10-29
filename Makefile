.DEFAULT_GOAL := install

.PHONY: clone install run

clone:
	@git clone https://github.com/j-tws/toy-robot-ruby.git

install:
	@bundle i

run:
	@ruby lib/app.rb