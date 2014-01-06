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
#usage: ssh [-1246AaCfgKkMNnqsTtVvXxYy] [-b bind_address] [-c cipher_spec]
#           [-D [bind_address:]port] [-e escape_char] [-F configfile]
#           [-I pkcs11] [-i identity_file]
#           [-L [bind_address:]port:host:hostport]
#           [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port]
#           [-R [bind_address:]port:host:hostport] [-S ctl_path]
#           [-W host:port] [-w local_tun[:remote_tun]]
#           [user@]hostname [command]


_ssh_list_hosts()
{
	(
		[ -f /etc/hosts ] && cat /etc/hosts | sed 's/\([^\]\)#.*/\1/;s/^#.*//;s/^[^[:space:]]*[[:space:]]//'
		[ -f /etc/ssh_config ] && cat /etc/ssh_config | grep -i '^host[[:space:]]*' | sed 's/^[Hh][Oo][Ss][Tt][[:space:]]*//;'
		[ -f ~/.ssh/config ] && cat ~/.ssh/config | grep -i '^host[[:space:]]*' | sed 's/^[Hh][Oo][Ss][Tt][[:space:]]*//;'
	) | xargs -n 1 | sort -u | grep -v '\*'
}

_ssh_complete() 
{
    local cur prev opts argopts paths
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
	opts="-1 -2 -4 -6 -A -a -C -f -g -K -k -M -N -n -q -s -T -t -V -v -X -x -Y -y"
	argopts="-b -c -D -e -F -I -i -L -l -m -O -o -P -R -S -W -w"

	
	if test -z "${argopts##${prev} *}" -o -z "${argopts##* ${prev} *}" -o -z "${argopts%%* ${prev}}"
	then {
		COMPREPLY=( $(compgen -f -d -- "${cur}") )
	}
	else case "${cur}" in
		-*)
			COMPREPLY=( $(compgen -W "${opts} ${argopts}" -- ${cur}) )
			return 0
		;;
		"")
			COMPREPLY=( $(compgen -W "$(_ssh_list_hosts)" -- ${cur}) )
			return 0
		;;
		*)
			COMPREPLY=( $(compgen -W "$(_ssh_list_hosts)" -- ${cur}) )
			return 0
		;;
	esac
	fi

}
complete -F _ssh_complete ssh


