# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>
# Public domain

# Xubuntu Docbook Customization Layer
XUBUNTUXSL=libs/xubuntu-html-chunk-cust.xsl

html: style
	xsltproc --xinclude -o ../build/desktop-guide/index.html $(XUBUNTUXSL) C/index.xml

style:
	mkdir -p ../build/desktop-guide/includes/
	mkdir -p ../build/desktop-guide/includes/navig/	
	mkdir -p ../build/desktop-guide/includes/admon/
	
	cp libs/*.css ../build/desktop-guide/includes/
	cp -r libs/images/* ../build/desktop-guide/includes/
	cp -r libs/admon/* ../build/desktop-guide/includes/admon/
	cp -r libs/navig/* ../build/desktop-guide/includes/navig/

.PHONY: html
