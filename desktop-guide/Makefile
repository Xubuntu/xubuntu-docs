# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>
# Public domain

# Xubuntu Docbook Customization Layer
XUBUNTUXSL=libs/xubuntu-html-chunk-cust.xsl

html: style
	xsltproc --xinclude -o ../build/desktop-guide/index.html $(XUBUNTUXSL) C/index.xml

style:
	mkdir -p ../build/libs
	cp -r libs/*css ../build/libs
	cp -r libs/images ../build/libs
	cp -r libs/admon ../build/libs
	cp -r libs/navig ../build/libs

.PHONY: html
