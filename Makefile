# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>

ifneq ($(wildcard desktop-guide/po/LINGUAS),)
   $(shell cd desktop-guide && ../scripts/translate.sh -u >/dev/null)
   TRANSLATIONS=$(shell cat desktop-guide/po/LINGUAS)
else
   TRANSLATIONS=$(shell basename -s .po -a desktop-guide/po/*po)
endif

all: clean desktop-guide startpage translate

desktop-guide:
	make -C desktop-guide html

translate:
	make -C desktop-guide translate

startpage:
	mkdir -p build/about/
	cp startpage/*.css build/about/
	cp startpage/*.png build/about/
	cp startpage/xubuntu-index-start.htx build/about/xubuntu-index.html
	for lang in $(TRANSLATIONS); do \
		echo -n "\t\t\t<li><a href=\"../$$lang/index.html\">"; grep Language-Team: desktop-guide/po/$$lang.po | awk '{print $$2 "</a></li>"}'; \
	done >> build/about/xubuntu-index.html
	cat startpage/xubuntu-index-end.htx >> build/about/xubuntu-index.html

test:
	make -C desktop-guide test

src-tarball:
	# exclude archive, backup, and bzr files
	tar cvfz xubuntu-doc.tar.gz  --exclude="*.tar.gz" --exclude="*~" --exclude "*.bzr*" *

clean:
	make -C desktop-guide clean
	rm -rf build

.PHONY: desktop-guide startpage translate
