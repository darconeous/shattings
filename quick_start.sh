#!/bin/bash

die () {
	echo $*
	exit 1
}

cd ~
[ -x .shattings/setup.sh ] && die 'Shattings already installed, run ~/.shattings/setup.sh'

echo 'Shattings Quick Installer'
echo ''
echo 'This script will place the shattings root in ~/.shattings,'
echo 'and then execute the shattings setup script.'
echo ''
read -p 'Press any key to continue installing or CTRL-C to abort.'

sleep 1

if ( which git 1>/dev/null )
then
	git clone http://github.com/darconeous/shattings.git .shattings || die Unable to clone shattings repository
else
	if ( which curl 1>/dev/null )
	then
		curl -L https://github.com/darconeous/shattings/tarball/master | tar xvz || die Unable to download archive
	else
		wget --output-document=/dev/stdout https://github.com/darconeous/shattings/tarball/master | tar xvz || die Unable to download archive
	fi
	mv darconeous-shattings* .shattings || die Unable to move archive contents
fi
cd .shattings || die Unable to move into .shattings
./setup.sh

