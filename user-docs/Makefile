# Makefile for the Xubuntu Documentation
# Xubuntu Project <xubuntu-devel@lists.ubuntu.com>

ifneq ($(TRANSLATUSER),)
    TRANSLATIONS = $(TRANSLATUSER)
endif

ifneq ($(TRANSOPTSUSER),)
    TRANSOPTS = $(TRANSOPTSUSER)
endif

# Specify threshold for translation
ifneq ($(TRANSPERC),)
    TRANSOPTSPERC = -t $(TRANSPERC)
endif

# Xubuntu Docbook Customization Layers
XUBUNTUXSL_HTML = ../libs-common/xubuntu-docbook-xhtml.xsl
XUBUNTUXSL_PDF = ../libs-common/xubuntu-docbook-pdf.xsl

# All available translations
TRANSALL = $(shell basename -s .po -a po/*.po)

all: html html-translations pdf pdf-translations

html: html-style
	xsltproc --xinclude -o ../build/user/C/index.html $(XUBUNTUXSL_HTML) C/index.xml

pdf:
	xsltproc --stringparam paper.type A4 --xinclude -o fo/C-A4.fo $(XUBUNTUXSL_PDF) C/index.xml
	../scripts/pdf-create.sh C

epub: epub-style
	xsltproc --xinclude -o ../build/user/C/ /usr/share/xml/docbook/stylesheet/nwalsh/epub3/chunk.xsl C/index.xml
	sed -i 's@../../libs-common@../libs@g' ../build/user/C/OEBPS/*
	cd ../build/user/C; \
	zip -0Xq xubuntu-documentation.epub mimetype; \
	zip -Xr9Dq xubuntu-documentation.epub *

html-style: ../common-libs
	mkdir -p ../build/user/libs
	cp -r libs/images ../build/user/libs/
	@touch html-style

epub-style:
	mkdir -p ../build/user/C/libs/images
	cp ../libs-common/images/*.png \
		libs/images/*.png \
		../build/user/C/libs/images/
	@touch epub-style

../common-libs:
	$(MAKE) -C .. common-libs

common-libs: ../common-libs

translate: | get-translations
	../scripts/translate.sh $(TRANSOPTS)
	../scripts/translators.sh $(TRANSOPTS)
	@touch translate

html-translations: html-style translate
	for dir in $(TRANSLATIONS); do \
		xsltproc --xinclude -o ../build/user/$$dir/index.html $(XUBUNTUXSL_HTML) $$dir/index.xml; \
	done

pdf-translations: translate
	for dir in $(TRANSLATIONS); do \
		xsltproc --stringparam paper.type A4 --xinclude -o fo/$$dir-A4.fo $(XUBUNTUXSL_PDF) $$dir/index.xml; \
	done
	../scripts/pdf-create.sh $(TRANSLATIONS)

test: translate
	set -e; \
	for dir in C $(TRANSLATIONS); do \
		../scripts/validate.sh $$dir/index.xml; \
	done

update-translations:
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard po/LINGUAS),)
		../scripts/translate.sh $(TRANSOPTSPERC) -u
		@touch update-translations
        endif
    endif

get-translations: update-translations
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard po/LINGUAS),)
            TRANSLATIONS = $(shell cat po/LINGUAS)
            TRANSOPTS = -g
        else
            TRANSLATIONS := $(TRANSALL)
            TRANSOPTS := -l "$(TRANSLATIONS)"
        endif
    else
        ifeq ($(TRANSOPTS),)
            TRANSOPTS := -l "$(TRANSLATIONS)"
        endif
    endif

clean:
	rm -rf ../build/libs-common ../build/user $(TRANSALL) fo mo ../common-libs html-style epub-style update-translations translate
