#!/bin/bash

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
echo '    ~/.screenrc'
echo '    ~/.inputrc'
echo '    ~/.bashrc'
[ `uname` = 'Darwin' ] && {
	echo '    ~/Library/KeyBindings/DefaultKeyBinding.dict'
}
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

[ `uname` = 'Darwin' ] && {
	if [ -e ~/Library/KeyBindings/DefaultKeyBinding.dict ]
	then
		echo Skipping ~/Library/KeyBindings/DefaultKeyBinding.dict
	else
		ln -s ../../.shattings/Library/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
	fi
}

echo 'Done! Shattings is now set up.'
echo 'Remember to edit the files mentioned above, if any.'
