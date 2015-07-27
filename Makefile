# Makefile for the Xubuntu Documentation
# Xubuntu Project <xubuntu-devel@lists.ubuntu.com>

VPATH = desktop-guide

# Include revision number
ifneq ($(REVNO),)
    VERSION = 
    VERSION += (Rev. $(REVNO))
endif

# All available translations
TRANSALL = $(shell basename -s .po -a desktop-guide/po/*.po)

all: clean startpage html html-translations pdf pdf-translations

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

update-translations:
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard desktop-guide/po/LINGUAS),)
		cd desktop-guide; \
		../scripts/translate.sh -u
        endif
    endif

get-translations: update-translations
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard desktop-guide/po/LINGUAS),)
            export TRANSLATIONS = $(shell cat desktop-guide/po/LINGUAS)
            export TRANSOPTS = -g
        else
            export TRANSLATIONS := $(TRANSALL)
            export TRANSOPTS := -l "$(TRANSLATIONS)"
        endif
    else
        export TRANSLATIONS
        export TRANSOPTS := -l "$(TRANSLATIONS)"
    endif

html:
	$(MAKE) -C desktop-guide html

epub:
	$(MAKE) -C desktop-guide epub

pdf:
	$(MAKE) -C desktop-guide pdf

translate: get-translations
	$(MAKE) -C desktop-guide translate

html-translations: translate
	$(MAKE) -C desktop-guide html-translations

pdf-translations: translate
	$(MAKE) -C desktop-guide pdf-translations

test: get-translations
	$(MAKE) -C desktop-guide test

src-tarball:
	# exclude archive, backup, and bzr files
	tar cvfz xubuntu-doc.tar.gz  --exclude="*.tar.gz" --exclude="*~" --exclude "*.bzr*" *

clean:
	$(MAKE) -C desktop-guide clean
	rm -rf build

.PHONY: startpage
