#!/bin/sh

####################################################################################
# Copyright (C) 2005-2006 Ubuntu Documentation Project (ubuntu-doc@lists.ubuntu.com)
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#    On Debian based systems a copy of the GPL can be found
#    at /usr/share/common-licenses/GPL
####################################################################################

# This script is for generating XML documents from po files downloaded from Launchpad
# Put your freshly downloaded po files into the po folder under each document, then run:
#
# $ translate.sh
#
# Optional parameters:
#	-g Translate for every language listed in po/LINGUAS
#	-l<language>
#	-u Update the list of translations in po/LINGUAS
#

translate() {
	lang=$(basename ${1} .po)
	echo " --Translating ${lang}"
	mkdir -p ${lang}
	for i in C/*xml; do
		xml=$(basename ${i} C/)
		xml2po --expand-all-entities --po-file po/${lang}.po C/${xml} >${lang}/${xml}
	done
	if [ -e C/${document}-C.omf ]; then
		xml2po --expand-all-entities --po-file ${1} C/${document}-C.omf >${lang}/${document}-${lang}.omf
		sed -i -e s@\"C\"@\"${lang}\"@g -e s@C/@${lang}/@g ${lang}/${document}-${lang}.omf
	fi
	../scripts/validate.sh ${lang}/index.xml
}

choose_language() {
	if [ ${1} ]; then
		translate "po/${1}.po"
	else
		for x in po/*.po; do
			translate ${x}
		done
	fi
}

shipped_languages() {
percent=80
for po in po/*.po
do
	if [ `msgfmt -o /dev/null --statistics $po 2>&1|awk '{printf("%.0f\n",$1 / ($1 + $4 + $7) * 100)}'` -ge "${percent}" ];then
		basename $po .po
	fi
done | tee po/LINGUAS
exit
}

while getopts ":gl:u" Option
do
	case ${Option} in
		g) generated=yes;;
		l) language=${OPTARG};;
		u) shipped_languages;;
		*) echo "Please specify an argument.";;
	esac
done

if [ ${language} ]; then
	choose_language ${language}
elif [ ${generated} ] && [ -f po/LINGUAS ];then
	for language in `cat po/LINGUAS`
	do
		choose_language ${language}
	done
else
		choose_language
fi
