#!/bin/sh

die () {
	echo $*
	exit 1
}

cd ~
[ -d .shattings ] && die Shattings already installed

if which -s git
then
	git clone git://github.com/darconeous/shattings.git .shattings || die Unable to clone shattings repository
else
	curl -L https://github.com/darconeous/shattings/tarball/master | tar xvz || die Unable to download archive
	mv darconeous-shattings* .shattings || die Unable to move archive contents
fi
cd .shattings || die Unable to move into .shattings
./setup.sh
. ~/.bashrc

