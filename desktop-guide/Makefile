# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>
# Public domain

# Xubuntu Docbook Customization Layer
XUBUNTUXSL=libs/xubuntu-html-chunk-cust.xsl

ifneq ($(wildcard po/LINGUAS),)
   $(shell ../scripts/translate.sh -u >/dev/null)
   OPTS=-g
   TRANSLATIONS=$(shell cat po/LINGUAS)
else
   OPTS=
   TRANSLATIONS=$(shell basename -s .po -a po/*po)
endif

html: style
	@echo "<para>Attributed on each language's page.</para>" > C/translators.xml
	xsltproc --xinclude -o ../build/desktop-guide/index.html $(XUBUNTUXSL) C/index.xml

style:
	mkdir -p ../build/libs
	cp -r libs/*css ../build/libs
	cp -r libs/images ../build/libs
	cp -r libs/admon ../build/libs
	cp -r libs/navig ../build/libs

translate:
	../scripts/translate.sh $(OPTS); \
	for dir in $(TRANSLATIONS); do \
		../scripts/translators.sh -l $$dir > $$dir/translators.xml ;\
		xsltproc --xinclude -o ../build/$$dir/index.html $(XUBUNTUXSL) $$dir/index.xml ;\
	done

test:
	set -e; \
	for dir in C $(TRANSLATIONS); do \
		../scripts/validate.sh $$dir/index.xml ;\
	done

clean:
	${RM} -r $(TRANSLATIONS) C/translators.xml

.PHONY: html translate
