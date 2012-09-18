# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>

all: clean desktop-guide startpage

desktop-guide:
	make -C desktop-guide html

startpage:
	cp -r startpage/ build/about

src-tarball:
	# exclude archive, backup, and bzr files
	tar cvfz xubuntu-doc.tar.gz  --exclude="*.tar.gz" --exclude="*~" --exclude "*.bzr*" *

clean:
	rm -rf build

commit-clean:
	find . -name "*.po" -exec rm \{\} \+
	find . -name "*.pot" -exec rm \{\} \+

.PHONY: desktop-guide startpage
