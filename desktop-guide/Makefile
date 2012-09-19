# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>
# Public domain

# Language code for documents
# Ex. LN=ja for japanese
LN=C

# Xubuntu Docbook Customization Layer
XUBUNTUXSL=libs/xubuntu-html-chunk-cust.xsl

html: style
	if [ $(LN) != "C" ]; then \
		../scripts/translate.sh -d desktop-guide -l $(LN); \
	fi; \
	xsltproc --xinclude -o ../build/$(LN)/index.html $(XUBUNTUXSL) $(LN)/index.xml

style:
	mkdir -p ../build/common/images/
	mkdir -p ../build/common/images/navig/	
	mkdir -p ../build/common/images/admon/
	
	cp libs/*.css ../build/common/
	cp -r libs/images/* ../build/common/images/
	cp -r libs/admon/* ../build/common/images/admon/
	cp -r libs/navig/* ../build/common/images/navig/

.PHONY: html
