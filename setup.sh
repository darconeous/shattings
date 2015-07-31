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

HOMEDIR=~
SHATDIR="$HOMEDIR/.shattings"

die () {
	echo $*
	exit 1
}

# set -x

echo 'This script will either create or update the following files:'
echo ''
echo '    ~/.bashrc'
echo '    ~/.vimrc'
echo '    ~/.kermrc'
echo '    ~/.screenrc'
echo '    ~/.tmux.conf'
echo '    ~/.inputrc'
echo '    ~/.profile'
echo '    ~/.Xdefaults'
echo '    ~/.gnupg/gpg.conf'
echo ''
echo 'If the file already exists, it will be non-destructively'
echo 'modified by appending commented-out commands. In this case'
echo 'you will need to edit the respective file manually to'
echo 'enable shattings.'
echo ''

read -p 'Press any key to continue setup or CTRL-C to abort.'
sleep 1

if [ -e "$HOMEDIR/.bashrc" ]
then
	if grep -q "$SHATDIR/bash/bashrc" $HOMEDIR/.bashrc
	then echo $HOMEDIR/.bashrc is already good to go.
	else
		{
			echo '# Uncomment to enable shattings'
			echo '# '"[ -d \"$SHATDIR\" ] && . \"$SHATDIR/bash/bashrc\""
		} >> "${HOMEDIR}/.bashrc"
		echo Added stub to existing $HOMEDIR/.bashrc, make sure you edit it
	fi
else
	{
		echo "[ -d \"$SHATDIR\" ] && . \"$SHATDIR/bash/bashrc\""
	} >> "${HOMEDIR}/.bashrc"
	echo Created $HOMEDIR/.bashrc
fi

if [ -e "$HOMEDIR/.profile" ]
then
	if grep -q ". ~/.bashrc" $HOMEDIR/.profile
	then echo $HOMEDIR/.profile is already good to go.
	else
		{
			echo '# Uncomment to enable shattings'
			echo '# '". ~/.bashrc"
		} >> "${HOMEDIR}/.profile"
		echo Added stub to existing $HOMEDIR/.profile, make sure you edit it
	fi
else
	{
		echo ". ~/.bashrc"
	} >> "${HOMEDIR}/.profile"
	echo Created $HOMEDIR/.profile
fi

if [ -e "${HOMEDIR}/.vimrc" ]
then
	if grep -q "$SHATDIR/vim/vimrc" $HOMEDIR/.vimrc
	then echo $HOMEDIR/.vimrc is already good to go.
	else
		{
			echo '" Uncomment to enable shattings'
			echo '" '"source $SHATDIR/vim/vimrc"
		} >> "${HOMEDIR}/.vimrc"
		echo Added stub to existing $HOMEDIR/.vimrc, make sure you edit it
	fi
else
	{
		echo "source $SHATDIR/vim/vimrc"
	} >> "${HOMEDIR}/.vimrc"
	echo Created $HOMEDIR/.vimrc
fi

if [ -d "${HOMEDIR}/.vim" ]
then
	echo  "$HOMEDIR/.vim" already exists, skipping...
else
	ln -s "${SHATDIR}/vim" "${HOMEDIR}/.vim"
	echo Linked $HOMEDIR/.vim
fi

if [ -e "${HOMEDIR}/.gnupg/gpg.conf" ]
then
	echo  "$HOMEDIR/.gnupg/gpg.conf" already exists, skipping...
else
	ln -s "${SHATDIR}/etc/gpg.conf" "${HOMEDIR}/.gnupg/gpg.conf"
	echo Linked $HOMEDIR/.gnupg/gpg.conf
fi

if [ -e "${HOMEDIR}/.screenrc" ]
then
	if grep -q "$SHATDIR/screen/screenrc" $HOMEDIR/.screenrc
	then echo $HOMEDIR/.screenrc is already good to go.
	else
		{
			echo '# Uncomment to enable shattings'
			echo '# '"source \"$SHATDIR/screen/screenrc\""
		} >> "${HOMEDIR}"/.screenrc
		echo Added stub to existing $HOMEDIR/.screenrc, make sure you edit it
	fi
else
	{
		echo "source \"$SHATDIR/screen/screenrc\""
	} >> "${HOMEDIR}"/.screenrc
	echo Created $HOMEDIR/.screenrc
fi

if [ -e "${HOMEDIR}/.inputrc" ]
then
	if grep -q "$SHATDIR/etc/inputrc" $HOMEDIR/.inputrc
	then echo $HOMEDIR/.inputrc is already good to go.
	else
		{
			echo '# Uncomment to enable shattings'
			echo '# '"\$include $SHATDIR/etc/inputrc\""
		} >> "${HOMEDIR}"/.inputrc
		echo Added stub to existing $HOMEDIR/.inputrc, make sure you edit it
	fi
else
	{
		echo "\$include $SHATDIR/etc/inputrc"
	} >> "${HOMEDIR}"/.inputrc
	echo Created $HOMEDIR/.inputrc
fi

if [ -e "${HOMEDIR}/.tmux.conf" ]
then
	if grep -q "$SHATDIR/etc/tmux.conf" $HOMEDIR/.tmux.conf
	then echo $HOMEDIR/.tmux.conf is already good to go.
	else
		{
			echo '# Uncomment to enable shattings'
			echo '# '"source \"$SHATDIR/etc/tmux.conf\""
		} >> "${HOMEDIR}"/.tmux.conf
		echo Added stub to existing $HOMEDIR/.tmux.conf, make sure you edit it
	fi
else
	{
		echo "source \"$SHATDIR/etc/tmux.conf\""
	} >> "${HOMEDIR}"/.tmux.conf
	echo Created $HOMEDIR/.tmux.conf
fi


if [ -e "${HOMEDIR}/.Xdefaults" ]
then
	echo "${HOMEDIR}/.Xdefaults already exists. Skipping..."
else
	ln -s "${SHATDIR}/etc/Xdefaults" "${HOMEDIR}/.Xdefaults"
	echo Linked "$HOMEDIR/.Xdefaults" to "${SHATDIR}/etc/Xdefaults".
fi

if [ -e "${HOMEDIR}/.kermrc" ]
then
	if grep -q "$SHATDIR/etc/kermrc" $HOMEDIR/.kermrc
	then echo $HOMEDIR/.kermrc is already good to go.
	else
		{
			echo '# Uncomment to enable shattings'
			echo '# '"take $SHATDIR/etc/kermrc"
		} >> "${HOMEDIR}/.kermrc"
		echo Added stub to existing $HOMEDIR/.kermrc, make sure you edit it
	fi
else
	{
		echo "take $SHATDIR/etc/kermrc"
	} >> "${HOMEDIR}/.kermrc"
	echo Created $HOMEDIR/.kermrc
fi

echo 'Done! Shattings is now set up.'
echo 'Remember to edit the files mentioned above, if any.'
