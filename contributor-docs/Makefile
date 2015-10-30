# Makefile for the Xubuntu Documentation
# Xubuntu Project <xubuntu-devel@lists.ubuntu.com>

# Xubuntu Docbook Customization Layers
XUBUNTUXSL_HTML = libs-common/xubuntu-docbook-xhtml.xsl

all: clean html

html: style
	xsltproc --xinclude -o ../build/contributor-docs/C/index.html $(XUBUNTUXSL_HTML) C/index.xml

style:
	mkdir -p ../build/libs-common
	cp -r ../libs-common ../build/
	mkdir -p ../build/contributor-docs
	ln -s ../libs-common ../build/contributor-docs/libs-common
#	mkdir -p ../build/contributor-docs/libs
#	cp -r libs/images ../build/contributor-docs/libs/
	@touch style

clean:
	rm -rf ../build style
