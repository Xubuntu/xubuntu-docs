#!/bin/sh

docs=$(basename -s -docs "$PWD")

ln -s ../libs-common libs-common

for lang in $@; do
	echo "Creating PDFs for $lang ..."
	mkdir -p "../build/$docs/$lang"
	fop -q -c ../libs-common/xubuntu-docbook-pdf-fonts.xml fo/$lang-A4.fo -pdf "../build/$docs/$lang/xubuntu-documentation-A4.pdf"
	sed 's@\(page-width\)="[^"]*" \(page-height\)="[^"]*"@\1="8.5in" \2="11in"@g' fo/$lang-A4.fo > fo/$lang-USletter.fo
	fop -q -c ../libs-common/xubuntu-docbook-pdf-fonts.xml fo/$lang-USletter.fo -pdf "../build/$docs/$lang/xubuntu-documentation-USletter.pdf"
done

rm libs-common