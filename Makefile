
.PHONY: install uninstall fmt test setup

setup:
	@./setup.sh

install:
	@./install.sh

uninstall:
	@./uninstall.sh

fmt:
	@shfmt -l -w -ci -i 2 .

test:
	@./tests.sh
