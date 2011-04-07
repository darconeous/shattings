#!/bin/sh

HOMEDIR=~
SHATDIR="$HOMEDIR/.shattings"

function die() {
	echo $*
	exit 1
}

set -x

if [ -e "$HOMEDIR/.bashrc" ]
then
	{
		echo '# Uncomment to enable'
		echo '# '". \"$SHATDIR/bash/bashrc\""
	} >> "${HOMEDIR}/.bashrc"
	echo Added stub to existing $HOMEDIR/.bashrc
else
	{
		echo ". \"$SHATDIR/bash/bashrc\""
	} >> "${HOMEDIR}/.bashrc"
	echo Created $HOMEDIR/.bashrc
fi

if [ -e "$HOMEDIR/.profile" ]
then
	{
		echo '# Uncomment to enable'
		echo '# '". ~/.bashrc"
	} >> "${HOMEDIR}/.profile"
	echo Added stub to existing $HOMEDIR/.profile
else
	{
		echo ". ~/.bashrc"
	} >> "${HOMEDIR}/.profile"
	echo Created $HOMEDIR/.profile
fi

if [ -e "${HOMEDIR}/.vimrc" ]
then
	{
		echo '" Uncomment to enable'
		echo '" '"source $SHATDIR/vim/vimrc"
	} >> "${HOMEDIR}/.vimrc"
	echo Added stub to existing $HOMEDIR/.vimrc
else
	{
		echo "source $SHATDIR/vim/vimrc"
	} >> "${HOMEDIR}/.vimrc"
	echo Created $HOMEDIR/.vimrc
fi

if [ -d "${HOMEDIR}/.vim" ]
then
	echo WARNING: "$HOMEDIR/.vim" already exists, skipping...
else
	ln -s "${SHATDIR}/vim" "${HOMEDIR}/.vim"
	echo Linked $HOMEDIR/.vim
fi

if [ -e "${HOMEDIR}/.screenrc" ]
then
	{
		echo '# Uncomment to enable'
		echo '# '"source \"$SHATDIR/screen/screenrc\""
	} >> "${HOMEDIR}"/.screenrc
	echo Added stub to existing $HOMEDIR/.screenrc
else
	{
		echo "source \"$SHATDIR/screen/screenrc\""
	} >> "${HOMEDIR}"/.screenrc
	echo Created $HOMEDIR/.screenrc
fi

[ -e ~/Library/KeyBindings/DefaultKeyBinding.dict ] && echo Skipping ~/Library/KeyBindings/DefaultKeyBinding.dict ||
ln -s ../../.shattings/Library/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

echo Done!
