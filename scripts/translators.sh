#!/bin/sh

build_creds () {
    for lang in $@; do
	translators=$(sed -n '/^msgid "translator-credits"/,/^$/ {s@^"[ ]*\(.\+\)[ ]\+https://launchpad.net/~\([^ \\"]\+\).*$@\t<listitem><para>\1 (\2)</para></listitem>@p;/^$/Q}' po/$lang.po | sort -u)
	if [ -z "$translators" ]; then
	    translators='\t<listitem><para>Translator data could not be acquired, please see <ulink url="https://translations.launchpad.net/xubuntu-docs">Launchpad</ulink>.</para></listitem>'
	fi
	printf "<itemizedlist>\n%b\n</itemizedlist>\n" "$translators" > $lang/translators.xml
    done
}

build_creds_alt () {
    for lang in $@; do
	mkdir -p po/mo/$lang/LC_MESSAGES
	msgfmt -o po/mo/$lang/LC_MESSAGES/xubuntu-docs.mo po/$lang.po
	translators=$(TEXTDOMAINDIR=po/mo LANGUAGE=$lang gettext -d xubuntu-docs -s 'translator-credits' | \
	    sed -n 's@^[ ]*\(.\+\)[ ]\+https://launchpad.net/~\([^ ]\+\).*$@\t<listitem><para>\1 (\2)</para></listitem>@p' | sort -u)
	if [ -z "$translators" ]; then
	    translators='\t<listitem><para>Translator data could not be acquired, please see <ulink url="https://translations.launchpad.net/xubuntu-docs">Launchpad</ulink>.</para></listitem>'
	fi
	printf "<itemizedlist>\n%b\n</itemizedlist>\n" "$translators" > $lang/translators.xml
    done
    rm -rf po/mo
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

