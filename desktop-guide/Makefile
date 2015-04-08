# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>
# Public domain

# Xubuntu Docbook Customization Layer
XUBUNTUXSL = libs/xubuntu-docbook-conf.xsl

# All available translations
TRANSALL = $(shell basename -s .po -a po/*.po)

all: clean html translate

html: style
	printf "<itemizedlist>\n\t<listitem><para>Attributed on each translation's page.</para></listitem>\n</itemizedlist>\n" > C/translators.xml
	xsltproc --xinclude -o ../build/C/index.html $(XUBUNTUXSL) C/index.xml
	sed -i 's@\(<p>The contributors to\) this translation of the \(documentation are:</p>\)@\1 the various translations of this \2@' ../build/C/credits-license.html

epub: epubstyle
	printf "<itemizedlist>\n\t<listitem><para>Attributed on each translation's page.</para></listitem>\n</itemizedlist>\n" > C/translators.xml
	xsltproc --xinclude -o ../build/C/ /usr/share/xml/docbook/stylesheet/nwalsh/epub3/chunk.xsl C/index.xml
	sed -i 's@\(<p>The contributors to\) this translation of the \(documentation are:</p>\)@\1 the various translations of this \2@' ../build/C/credits-license.html
	cd ../build/C; \
	zip -0Xq xubuntu-docs.epub mimetype; \
	zip -Xr9Dq xubuntu-docs.epub *

style:
	mkdir -p ../build/libs
	cp -r   libs/*.css \
		libs/images \
		libs/admon \
		libs/navig \
		../build/libs/

epubstyle:
	mkdir -p ../build/C/libs/images
	cp      libs/images/preferences-desktop.png \
		libs/images/system-lock-screen.png \
		libs/images/system-log-out.png \
		libs/images/location_icon.png \
		libs/images/package_icon.png \
		libs/images/menu_icon.png \
		libs/images/key_icon.png \
		../build/C/libs/images/

translate: get-translations
	../scripts/translate.sh $(TRANSOPTS)
	../scripts/translators.sh $(TRANSOPTS)
	for dir in $(TRANSLATIONS); do \
		xsltproc --xinclude -o ../build/$$dir/index.html $(XUBUNTUXSL) $$dir/index.xml; \
	done

test: get-translations
	set -e; \
	for dir in C $(TRANSLATIONS); do \
		../scripts/validate.sh $$dir/index.xml; \
	done

get-translations:
ifeq ($(TRANSLATIONS),)
    ifneq ($(wildcard po/LINGUAS),)
	../scripts/translate.sh -u
        TRANSLATIONS := $(shell cat po/LINGUAS)
        TRANSOPTS = -g
    else
        TRANSLATIONS := $(TRANSALL)
    endif
endif

clean:
	${RM} -r $(TRANSALL) C/translators.xml
