#!/bin/sh

for lang in $@; do
    mkdir -p ../build/$lang
    fop -c libs/xubuntu-docbook-pdf-fonts.xml fo/$lang-A4.fo -pdf ../build/$lang/xubuntu-documentation-A4.pdf
    sed 's@\(page-width\)="[^"]*" \(page-height\)="[^"]*"@\1="8.5in" \2="11in"@g' fo/$lang-A4.fo > fo/$lang-USletter.fo
    fop -c libs/xubuntu-docbook-pdf-fonts.xml fo/$lang-USletter.fo -pdf ../build/$lang/xubuntu-documentation-USletter.pdf
    if [ -f ../build/$lang/index.html ]; then 
	sed -i '/<div .*id="masthead"/,/<div class=/ {/<div class=/ a\
      <div class="pdf-links">\
        <span class="title">PDF:</span>\
        <ul class="inline">\
          <li><a href="xubuntu-documentation-A4.pdf">A4</a></li>\
          <li><a href="xubuntu-documentation-USletter.pdf">US Letter</a></li>\
        </ul>\
      </div>
	}' ../build/$lang/*.html
    fi
done