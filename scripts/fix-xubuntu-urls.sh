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
# remarks: Use this script to convert ghelp links to xref links that are suitable for Xubuntu documentation.
# usage: ./fix-xubuntu-urls.sh
####################################################################################

cd scripts
find ../ -name '*.xml' -print | xargs sed -i '/ulink/{N;N;N}; s#<ulink type="help" url="ghelp:office">[[:space:]]*Office Applications and Documents[[:space:]]*</ulink>#<xref linkend="office"/>#g'
<ulink type="help" url="ghelp:user-guide#panels">
