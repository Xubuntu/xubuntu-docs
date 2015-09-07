#!/bin/sh

build_creds () {
	for lang in $@; do
		echo '<?xml version="1.0" encoding="utf-8"?><section>' > $lang/translators.xml
		translator_credits=$(tail -q -n +2 $lang/xi-translator-credits.xml)
		echo $translator_credits >> $lang/translators.xml

		translators=$(sed -n '/^msgid "translator-credits"/,/^$/ {s@^"[ ]*\(.\+\)[ ]\+https://launchpad.net/~\([^ \\"]\+\).*$@\t<listitem><para>\1 (\2)</para></listitem>@p;/^$/Q}' po/$lang.po | sort -u)
		if [ -z "$translators" ]; then
			translators_not_found=$(tail -q -n +2 $lang/xi-translators-not-found.xml)
			echo $translators_not_found >> $lang/translators.xml
		else
			printf "<itemizedlist>\n%b\n</itemizedlist>\n" "$translators" >> $lang/translators.xml
		fi

		echo "</section>" >> $lang/translators.xml
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

