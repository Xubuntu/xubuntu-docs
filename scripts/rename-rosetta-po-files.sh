# This script renames po files downloaded from Launchpad into a standard format filename. It works around this bug in Launchpad: https://bugs.launchpad.net/bugs/353981

for i in `cat libs/shipped-docs` serverguide ; do cd $i/po ; mv ../*.po . ; for x in ubuntu-docs-$i-*.po ; do echo $x ; mv $x ${x#ubuntu-docs-$i-} ; done ; cd ../../ ; done
