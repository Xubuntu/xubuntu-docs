# Makefile for the Xubuntu Documentation
# Xubuntu Project <xubuntu-devel@lists.ubuntu.com>

# Include revision number
ifneq ($(REVNO),)
    VERSION = 
    VERSION += (Rev. $(REVNO))
endif

# Specify threshold for translation
ifneq ($(TRANSPERC),)
    export TRANSOPTSPERC = -t $(TRANSPERC)
endif

# All available translations
TRANSALLUSER = $(shell basename -s .po -a user-docs/po/*.po)
TRANSALLCONTR = $(shell basename -s .po -a contributor-docs/po/*.po)

ifeq ($(TRANSALLCONTR),*)
    TRANSALLCONTR =
endif

# Translation links
TRSLINKSUSER = $(shell for lang in $(TRANSLATUSER); do \
        awk -F '[\t]+' -v lang="$$lang" '$$1 == lang {print "\t\t\t\t\t\t<li><a href=\\\"user/" lang "/index.html\\\">" $$2 "</a></li>\\n"; f=1; exit} END {exit !f}' libs-common/language-names || \
        sed -n "/^\"Language-Team:/ {s|^\"Language-Team: \([^<]\+\) <.*$$|\t\t\t\t\t\t<li><a href=\\\\\"user/$$lang/index.html\\\\\">\1</a></li>\\\n|p;q}" user-docs/po/$$lang.po; \
    done | sed '$$ s/\\n$$//')

TRSLINKSCONTR = $(shell for lang in $(TRANSLATCONTR); do \
        awk -F '[\t]+' -v lang="$$lang" '$$1 == lang {print "\t\t\t\t\t\t<li><a href=\\\"contributor/" lang "/index.html\\\">" $$2 "</a></li>\\n"; f=1; exit} END {exit !f}' libs-common/language-names || \
        sed -n "/^\"Language-Team:/ {s|^\"Language-Team: \([^<]\+\) <.*$$|\t\t\t\t\t\t<li><a href=\\\\\"contributor/$$lang/index.html\\\\\">\1</a></li>\\\n|p;q}" contributor-docs/po/$$lang.po; \
    done | sed '$$ s/\\n$$//')

all: startpage user-all

user-all: user-html user-html-translations user-pdf user-pdf-translations

contributor-all: contributor-html contributor-html-translations contributor-pdf contributor-pdf-translations

startpage: startpage-style user-get-translations contributor-get-translations
	sed "s@<a href=\"[^\"]\+\">Official Documentation</a>@&$(VERSION)@; \
	    s@^\(.*\)<!-- user docs translations -->.*@$(TRSLINKSUSER)@" startpage/index.html > build/index.html
	sed -i "s@<a href=\"[^\"]\+\">Contributor Documentation</a>@&$(VERSION)@; \
	    s@^\(.*\)<!-- contributor docs translations -->.*@$(if $(TRSLINKSCONTR),$(TRSLINKSCONTR),\1)@" build/index.html

startpage-style: common-libs
	cp startpage/*.css build/
	@touch startpage-style

common-libs:
	mkdir -p build/libs-common
	cp -r libs-common/css \
		libs-common/images \
		build/libs-common/
	@touch common-libs

user-docs/update-translations:
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard user-docs/po/LINGUAS),)
		cd user-docs; \
		../scripts/translate.sh $(TRANSOPTSPERC) -u
		@touch user-docs/update-translations
        endif
    endif

user-update-translations: user-docs/update-translations

user-get-translations: user-docs/update-translations
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard user-docs/po/LINGUAS),)
            export TRANSLATUSER = $(shell cat user-docs/po/LINGUAS)
            export TRANSOPTSUSER = -g
        else
            export TRANSLATUSER := $(TRANSALLUSER)
            export TRANSOPTSUSER := -l "$(TRANSLATUSER)"
        endif
    else
        export TRANSLATUSER := $(TRANSLATIONS)
        export TRANSOPTSUSER := -l "$(TRANSLATIONS)"
    endif

contributor-docs/update-translations:
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard contributor-docs/po/LINGUAS),)
		cd contributor-docs; \
		../scripts/translate.sh $(TRANSOPTSPERC) -u
		@touch contributor-docs/update-translations
        endif
    endif

contributor-update-translations: contributor-docs/update-translations

contributor-get-translations: contributor-docs/update-translations
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard contributor-docs/po/LINGUAS),)
            export TRANSLATCONTR = $(shell cat contributor-docs/po/LINGUAS)
            export TRANSOPTSCONTR = -g
        else
            export TRANSLATCONTR := $(TRANSALLCONTR)
            export TRANSOPTSCONTR := -l "$(TRANSLATCONTR)"
        endif
    else
        export TRANSLATCONTR := $(TRANSLATIONS)
        export TRANSOPTSCONTR := -l "$(TRANSLATIONS)"
    endif

user-html:
	$(MAKE) -C user-docs html

user-epub:
	$(MAKE) -C user-docs epub

user-pdf:
	$(MAKE) -C user-docs pdf

user-translate: user-get-translations
	$(MAKE) -C user-docs translate

user-html-translations: user-translate
	$(MAKE) -C user-docs html-translations

user-pdf-translations: user-translate
	$(MAKE) -C user-docs pdf-translations

contributor-html:
	$(MAKE) -C contributor-docs html

contributor-epub:
	$(MAKE) -C contributor-docs epub

contributor-pdf:
	$(MAKE) -C contributor-docs pdf

contributor-translate: contributor-get-translations
	$(MAKE) -C contributor-docs translate

contributor-html-translations: contributor-translate
	$(MAKE) -C contributor-docs html-translations

contributor-pdf-translations: contributor-translate
	$(MAKE) -C contributor-docs pdf-translations

test:
	$(MAKE) -C user-docs test
	$(MAKE) -C contributor-docs test

src-tarball:
	# exclude archive, VCS, and backups
	tar -czf xubuntu-docs.tar.gz --exclude='xubuntu-docs.tar.gz' --exclude-vcs --exclude-backups .

pot:
	scripts/get-pot.sh user-docs contributor-docs

clean:
	$(MAKE) -C user-docs clean
	$(MAKE) -C contributor-docs clean
	rm -rf build common-libs startpage-style xubuntu-docs.tar.gz

.PHONY: startpage
