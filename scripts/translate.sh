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
#	-d<documentname>
#	-l<language>
#

translate () {
	y=$(basename ${1} .po)
	echo " --Translating ${y}"
	mkdir -p ${y}
	for i in C/*xml; do
		j=$(basename ${i} C/)
		k=$(basename ${j} .xml)
		xml2po -e -p po/${y}.po C/${j} >${y}/${j}
	done
	if [ -e C/${document}-C.omf ]; then
	    xml2po -e -p ${1} C/${document}-C.omf >${y}/${document}-${y}.omf
	    sed -i -e s@\"C\"@\"${y}\"@g -e s@C/@${y}/@g ${y}/${document}-${y}.omf
	fi
	../scripts/validate.sh ${y}/${document}.xml
}

choose_language () {
	echo "Entering ${1}"
	cd ${1}
	if [ ${2} ]; then
		translate "po/${2}.po"
	else
		for x in po/*.po; do
			translate ${x}
		done
	fi
	rm .xml2po.mo
	cd ..
}

while getopts "d:l:" Option
do
	case ${Option} in
		d) document=${OPTARG};;
		l) lang=${OPTARG};;
		*) echo "Please specify an argument.";;
	esac
done

if [ ${document} ]; then
	choose_language ${document} ${lang}
else
	for doc in `cat libs/shipped-docs`
	do
		choose_language ${doc} ${lang}
	done
fi

