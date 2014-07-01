#!/bin/sh

CURDIR=$(pwd)/po/

get_languages() {
if [ "$generated" = yes ];then
   languages=$(cat po/LINGUAS)
elif [ -n $language ];then
   languages=$language
else
   languages=$(basename -s.po $CURDIR/*.po)
fi
}

build_creds() {
#for lang in `basename -s.po *.po`;do  ## Good for testing, uses all translations it can find.
echo "<itemizedlist>"
for lang in $languages;do
	mkdir -p $CURDIR/mo/$lang/LC_MESSAGES/
	msgfmt -o $CURDIR/mo/$lang/LC_MESSAGES/xubuntu-docs.mo $CURDIR/$lang.po
	TEXTDOMAINDIR=$CURDIR/mo/ LANGUAGE=$lang gettext -d xubuntu-docs -s 'translator-credits' | \
		sed -e 's@^  @\t<listitem><para>@' -e '/launchpad.net/s@$@)</para></listitem>@' \
		-e 's@https://launchpad.net/~@(@' -e /Launchpad\ Contributions/d -e /^translator-credits$/d
done | sort | uniq
echo "</itemizedlist>"
rm -rf $CURDIR/mo/
}

grep_creds() {
## Don't build, just grep.
## This is incomplete and unused, potentially helpful later.
for lang in $languages;do
	echo  msggrep --msgid -F -e 'translator-credits' $lang.po
done
}

while getopts ":gl:" Option
do
        case ${Option} in
		g) generated=yes;;
		l) language=${OPTARG};;
		*) echo "Please specify an argument.";;
	esac
done

get_languages
build_creds
