# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>

ifneq ($(REVNO),)
    VERSION = 
    VERSION += (Rev. $(REVNO))
endif

all: clean startpage html translate

startpage: get-translations
	mkdir -p build
	cp      startpage/*.css \
		startpage/*.png \
		build/
	sed "s@\(<a href=\"\).*\([^/]\+/index\.html\">Official Documentation</a>\)@\1\2$(VERSION)@" startpage/xubuntu-index-start.htx > build/index.html
	for lang in $(TRANSLATIONS); do \
	    	awk -v lang="$$lang" '$$1 == lang {print "\t\t\t<li><a href=\"" lang "/index.html\">" $$2 "</a></li>"; f=1; exit} END {exit !f}' desktop-guide/po/LINGUANAMES || \
		awk -v lang="$$lang" '$$1 == "\"Language-Team:" {print "\t\t\t<li><a href=\"" lang "/index.html\">" $$2 "</a></li>"; exit}' desktop-guide/po/$$lang.po; \
	done >> build/index.html
	cat startpage/xubuntu-index-end.htx >> build/index.html

get-translations:
ifneq ($(wildcard desktop-guide/po/LINGUAS),)
	cd desktop-guide; \
	../scripts/translate.sh -u
    export TRANSLATIONS := $(shell cat desktop-guide/po/LINGUAS)
    export TRANSOPTS = -g
else
    export TRANSLATIONS := $(shell basename -s .po -a desktop-guide/po/*.po)
endif

html:
	make -C desktop-guide html

epub:
	make -C desktop-guide epub

translate:
	make -C desktop-guide translate

test:
	make -C desktop-guide test

src-tarball:
	# exclude archive, backup, and bzr files
	tar cvfz xubuntu-doc.tar.gz  --exclude="*.tar.gz" --exclude="*~" --exclude "*.bzr*" *

clean:
	make -C desktop-guide clean
	rm -rf build

.PHONY: startpage
