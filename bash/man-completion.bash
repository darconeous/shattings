#!/bin/sh
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

# Note to self:
# usage: man [-adfhktwW] [section] [-M path] [-P pager] [-S list] [-m system] [-p string] name ...

[ "$MANPATH" = "" ] && export MANPATH="`man -w 2> /dev/null`"

_man_complete() 
{
    local cur prev opts paths section
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
	opts="-a -d -f -h -k -t -w -W -M -P -S -M -p --path"

	paths="$MANPATH"
	[ "$paths" = "" ] && return 1


	[ "$section" != "" ] &&
		paths="`tr ':\n' '\000' <<<$paths | xargs -0 -n 1 printf "%s/man$section:"`"
	
	case "${prev}" in
		-M|-P|-S|-m|-p|-C);;
		*)
			case "${cur}" in
				-*)
					COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
					return 0
				;;
				1|2|3|4|5|6|7|8|9)
					COMPREPLY=( $(compgen -W "1 2 3 4 5 6 7 8 9" -- ${cur}) )
					return 0
				;;
				"")
					if [ "$section" = "" ]
					then COMPREPLY=( $(compgen -W "${opts} 1 2 3 4 5 6 7 8 9" -- ${cur}) )
					else COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
					fi
					return 0
				;;
				*)
					COMPREPLY=( $(compgen -W "`tr ':\n' '\000' <<<$paths | xargs -0 -n 1 -I % find % -type f -name "$(printf %q $cur)"'*' -exec basename {} ';' 2>/dev/null |sed 's/\([^.]*\)\..*$/\1/'`" -- ${cur} 2>/dev/null) )
					return 0
				;;
			esac
		;;
	esac

}
complete -F _man_complete man


