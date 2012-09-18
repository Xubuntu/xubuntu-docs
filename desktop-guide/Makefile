# Makefile for the Xubuntu Documentation
# Ubuntu Documentation Project <ubuntu-doc@lists.ubuntu.com>

# Xubuntu Docbook Customization Layer
XUBUNTUXSL=libs/xubuntu-html-chunk-cust.xsl

html: style xml2po
	xsltproc --xinclude -o ../build/index.html $(XUBUNTUXSL) index.xml

style:
	mkdir -p ../build/common/images/
	mkdir -p ../build/common/images/navig/	
	mkdir -p ../build/common/images/admon/
	
	cp libs/*.css ../build/common/
	cp -r libs/images/* ../build/common/images/
	cp -r libs/admon/* ../build/common/images/admon/
	cp -r libs/navig/* ../build/common/images/navig/

xml2po:
#	xml2po -e -o administrative-tasks/po/administrative-tasks.pot administrative-tasks/C/*.xml
#	xml2po -e -o command-line/po/command-line.pot command-line/C/*.xml
#	xml2po -e -o guide-default-apps/po/guide-default-apps.pot guide-default-apps/C/*.xml
#	xml2po -e -o guide-desktop/po/guide-desktop.pot guide-desktop/C/*.xml
#	xml2po -e -o guide-keeping-safe/po/guide-keeping-safe.pot guide-keeping-safe/C/*.xml
#	xml2po -e -o hardware-devices/po/hardware-devices.pot hardware-devices/C/*.xml
#	xml2po -e -o internet-networks/po/internet-networks.pot internet-networks/C/*.xml
#	xml2po -e -o managing-applications/po/managing-applications.pot managing-applications/C/*.xml
#	xml2po -e -o media-apps/po/media-apps.pot media-apps/C/*.xml
#	xml2po -e -o migrating-upgrading/po/migrating-upgrading.pot migrating-upgrading/C/*.xml
#	xml2po -e -o printing-scanning/po/printing-scanning.pot printing-scanning/C/*.xml
#	xml2po -e -o what-is-xubuntu/po/what-is-xubuntu.pot what-is-xubuntu/C/*.xml
#	xml2po -e -o appendix/po/appendix.pot appendix/C/*.xml

.PHONY: html
