#!/bin/sh

die () {
	echo $*
	exit 1
}

cd ~
curl -L https://github.com/darconeous/shattings/tarball/master | tar xvz || die Unable to download archive
mv darconeous-shattings* .shattings || die Unable to move archive contents
cd .shattings || die Unable to move into .shattings
./setup.sh
. ~/.bashrc

