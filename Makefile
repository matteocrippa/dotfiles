
.PHONY: install uninstall fmt test setup chroot

setup:
	@./setup.sh

chroot:
	@./chroot.sh

install:
	@./install.sh

uninstall:
	@./uninstall.sh

fmt:
	@shfmt -l -w -ci -i 2 .

test:
	@./tests.sh
