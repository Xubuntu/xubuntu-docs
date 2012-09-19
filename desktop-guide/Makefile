# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>
# Public domain

# Xubuntu Docbook Customization Layer
XUBUNTUXSL=libs/xubuntu-html-chunk-cust.xsl

html: style
	xsltproc --xinclude -o ../build/desktop-guide/index.html $(XUBUNTUXSL) C/index.xml

style:
	mkdir -p ../build/common/images/
	mkdir -p ../build/common/images/navig/	
	mkdir -p ../build/common/images/admon/
	
	cp libs/*.css ../build/common/
	cp -r libs/images/* ../build/common/images/
	cp -r libs/admon/* ../build/common/images/admon/
	cp -r libs/navig/* ../build/common/images/navig/

.PHONY: html
