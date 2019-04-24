
.PHONY: install uninstall fmt test gpt lvm

gpt:
	@./gpt.sh
	
lvm:
	@./lvm.sh
	
install:
	@./install.sh

uninstall:
	@./uninstall.sh

fmt:
	@shfmt -l -w -ci -i 2 .

test:
	@./tests.sh
