
# usage: man [-adfhktwW] [section] [-M path] [-P pager] [-S list] [-m system] [-p string] name ...

_man_complete() 
{
    local cur prev opts paths section
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
	opts="-a -d -f -h -k -t -w -W -M -P -S -M -p --path"

	paths="`man -w`"
	
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
					COMPREPLY=( $(compgen -W "`tr ':\n' '\000' <<<$paths | xargs -0 -n 1 -J % find % -type f -name "$(printf %q $cur)"'*' -exec basename {} ';' | sed 's/\([^.]*\)\..*$/\1/'`" -- ${cur}) )
					return 0
				;;
			esac
		;;
	esac

}
complete -F _man_complete man


