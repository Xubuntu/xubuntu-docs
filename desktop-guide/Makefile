# Makefile for the Xubuntu Documentation
# Xubuntu Project <xubuntu-devel@lists.ubuntu.com>

# Xubuntu Docbook Customization Layers
XUBUNTUXSL_HTML = libs/xubuntu-docbook-xhtml.xsl
XUBUNTUXSL_PDF = libs/xubuntu-docbook-pdf.xsl

# All available translations
TRANSALL = $(shell basename -s .po -a po/*.po)

all: clean html translate

html: style
	printf "<itemizedlist>\n\t<listitem><para>Attributed on each translation's page.</para></listitem>\n</itemizedlist>\n" > C/translators.xml
	xsltproc --xinclude -o ../build/C/index.html $(XUBUNTUXSL_HTML) C/index.xml
	sed -i 's@\(<p>The contributors to\) this translation of the \(documentation are:</p>\)@\1 the various translations of this \2@' ../build/C/credits-license.html

epub: epubstyle
	printf "<itemizedlist>\n\t<listitem><para>Attributed on each translation's page.</para></listitem>\n</itemizedlist>\n" > C/translators.xml
	xsltproc --xinclude -o ../build/C/ /usr/share/xml/docbook/stylesheet/nwalsh/epub3/chunk.xsl C/index.xml
	sed -i 's@\(<p>The contributors to\) this translation of the \(documentation are:</p>\)@\1 the various translations of this \2@' ../build/C/credits-license.html
	cd ../build/C; \
	zip -0Xq xubuntu-docs.epub mimetype; \
	zip -Xr9Dq xubuntu-docs.epub *

pdf:
	mkdir -p ../build/C
	printf "<itemizedlist>\n\t<listitem><para>Attributed on each translation's page.</para></listitem>\n</itemizedlist>\n" > C/translators.xml
	sed -i 's@\(>The contributors to\) this translation of the \(documentation are:</\)@\1 the various translations of this \2@' fo/C.fo
	for paper in A4 USletter; do \
		xsltproc --stringparam paper.type "$$paper" --xinclude -o fo/C-$$paper.fo $(XUBUNTUXSL_PDF) C/index.xml; \
		fop -c libs/xubuntu-docbook-pdf.xml fo/C-$$paper.fo -pdf ../build/C/xubuntu-documentation-$$paper.pdf; \
	done

pdf-test:
	mkdir -p ../build/C
	printf "<itemizedlist>\n\t<listitem><para>Attributed on each translation's page.</para></listitem>\n</itemizedlist>\n" > C/translators.xml
	for paper in A4 USletter; do \
		xsltproc --stringparam paper.type "$$paper" --stringparam monospace.font-family "Droid Sans" --stringparam title.font.family "Droid Sans" --stringparam body.font.family "Droid Sans" --xinclude -o fo/C-$$paper.fo $(XUBUNTUXSL_PDF) C/index.xml; \
		fop -c libs/xubuntu-docbook-pdf.xml fo/C-$$paper.fo -pdf ../build/C/xubuntu-documentation-$$paper.pdf; \
	done

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
		xsltproc --xinclude -o ../build/$$dir/index.html $(XUBUNTUXSL_HTML) $$dir/index.xml; \
	done

translate-pdf: get-translations
	../scripts/translate.sh $(TRANSOPTS)
	../scripts/translators.sh $(TRANSOPTS)
	for dir in $(TRANSLATIONS); do \
		mkdir -p ../build/$$dir; \
		for paper in A4 USletter; do \
			xsltproc --stringparam paper.type "$$paper" --xinclude -o fo/$$dir-$$paper.fo $(XUBUNTUXSL_PDF) $$dir/index.xml; \
			fop -c libs/xubuntu-docbook-pdf.xml fo/$$dir-$$paper.fo -pdf ../build/$$dir/xubuntu-documentation-$$paper.pdf; \
		done \
	done

test: get-translations
	set -e; \
	for dir in C $(TRANSLATIONS); do \
		../scripts/validate.sh $$dir/index.xml; \
	done

update-translations:
    ifeq ($(TRANSLATIONS),)
        ifneq ($(wildcard po/LINGUAS),)
		../scripts/translate.sh -u
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
	rm -rf $(TRANSALL) C/translators.xml fo/
