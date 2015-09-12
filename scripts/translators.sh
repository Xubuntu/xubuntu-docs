#!/bin/sh

build_creds () {
	for lang in $@; do
		translators=$(sed -n '/^msgid "translator-credits"/,/^$/ {s@^"[ ]*\(.\+\)[ ]\+https://launchpad.net/~\([^ \\"]\+\).*$@\t<listitem><para>\1 (\2)</para></listitem>@p;/^$/Q}' po/$lang.po | sort -u)
		if [ -z "$translators" ]; then
			cp $lang/xi-translators-not-found.xml $lang/translators.xml
		else
			cp $lang/xi-translator-credits.xml $lang/translator-credits.xml
			printf '<?xml version="1.0" encoding="utf-8"?>\n' > $lang/translators.xml
			printf "<itemizedlist>\n%b\n</itemizedlist>" "$translators" >> $lang/translators.xml
		fi
	done
}

while getopts ":gl:" opt; do
	case $opt in
		g)
			generated="yes";;
		l)
			language=$OPTARG;;
	esac
done

if [ "$generated" = "yes" ]; then
	if [ ! -f po/LINGUAS ]; then
		../scripts/translate.sh -u
	fi
	build_creds $(cat po/LINGUAS)
elif [ -n "$language" ]; then
	build_creds $language
else
	build_creds $(basename -s .po -a po/*.po)
fi

