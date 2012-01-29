#!/bin/bash
#
# This file was written by Robert Quattlebaum <darco@deepdarc.com>.
# 
# This work is provided as-is. Unless otherwise provided in writing,
# Robert Quattlebaum makes no representations or warranties of any
# kind concerning this work, express, implied, statutory or otherwise,
# including without limitation warranties of title, merchantability,
# fitness for a particular purpose, non infringement, or the absence
# of latent or other defects, accuracy, or the present or absence of
# errors, whether or not discoverable, all to the greatest extent
# permissible under applicable law.
# 
# To the extent possible under law, Robert Quattlebaum has waived all
# copyright and related or neighboring rights to this work. This work
# is published from the United States.
# 
# I, Robert Quattlebaum, dedicate any and all copyright interest in
# this work to the public domain. I make this dedication for the
# benefit of the public at large and to the detriment of my heirs and
# successors. I intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to
# this code under copyright law. In jurisdictions where this is not
# possible, I hereby release this code under the Creative Commons
# Zero (CC0) license.
# 
#  * <http://creativecommons.org/publicdomain/zero/1.0/>
#

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

