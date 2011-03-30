#!/bin/sh

function die() {
	echo $*
	exit 1
}

set -x

ln -s .shattings/profile ~/.profile
ln -s .shattings/vim/vimrc ~/.vimrc
ln -s .shattings/vim ~/.vim

