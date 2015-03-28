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
#	-l <language>
#	-u Update the list of languages in po/LINGUAS
#

translate () {
    for lang in $@; do
	echo "Translating $lang ..."
	mkdir -p $lang
	for xml in C/*.xml; do
	    xml=$(basename $xml)
	    xml2po --expand-all-entities --po-file po/$lang.po C/$xml > $lang/$xml
	done
    done
}

shipped_languages () {
    percreq="70"
    echo "Updating LINGUAS ..."
    for po in po/*.po; do
	percdone=$(msgfmt -o /dev/null --statistics $po 2>&1 | awk '{printf "%.0f\n", $1 / ($1 + $4 + $7) * 100}')
	if [ "$percdone" -ge "$percreq" ]; then
	    basename $po .po
	fi
    done | tee po/LINGUAS
}

while getopts ":gl:u" opt; do
    case $opt in
	g)
	    generated="yes";;
	l)
	    language=$OPTARG;;
	u)
	    shipped_languages
	    exit;;
    esac
done

if [ "$generated" = "yes" ]; then
    if [ ! -f po/LINGUAS ]; then
    	shipped_languages
    fi
    translate $(cat po/LINGUAS)
elif [ -n "$language" ]; then
    translate $language
else
    translate $(basename -s .po -a po/*.po)
fi
