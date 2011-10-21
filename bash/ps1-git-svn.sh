#!/bin/bash

# Original version of this file:
# https://github.com/nesono/nesono-bin/blob/master/bashtils/ps1status

# Prompt setup, with SCM status
function parse_git_branch() {
	local DIRTY STATUS BRANCH MODE TOPLEVEL

	# If this environment variable is set, we skip this part.
	[ "${DISABLE_GIT_PROMPT}" = "" ] || return

	TOPLEVEL="$(git rev-parse --show-toplevel 2>/dev/null)"
	[ "$TOPLEVEL" = "" ] && return
	[ "$TOPLEVEL" = "/.git" ] && return
	[ "$TOPLEVEL" = "/" ] && return
	STATUS=$(git status --porcelain 2>/dev/null)
	[ $? -eq 128 ] && return
	[ -z "$(echo "$STATUS" | grep -e '^ [RDMA]')"    ] || DIRTY="*"
	[ -z "$(echo "$STATUS" | grep -e '^?? ')"    ] || DIRTY="${DIRTY}?"
	[ -z "$(echo "$STATUS" | grep -e '^[RMDA]')" ] || DIRTY="${DIRTY}+"
	[ -z "$(git stash list)" ]                    || DIRTY="${DIRTY}^"
	BRANCH="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')"
	if [ -f "${TOPLEVEL}/.git/rebase-merge/interactive" ]
	then
		BRANCH='['$(basename `cat "${TOPLEVEL}/.git/rebase-merge/head-name"`)']'
		MODE="<rebase-i>"
	elif [ -f "${TOPLEVEL}/.git/rebase-apply/rebasing" ]
	then MODE="<rebase>"
	elif [ -f "${TOPLEVEL}/.git/rebase-apply/applying" ]
	then MODE="<am>"
	elif [ -d "${TOPLEVEL}/.git/rebase-apply" ]
	then MODE="<rebase?>"
	elif [ -f "${TOPLEVEL}/.git/MERGE_HEAD" ]
	then MODE="<merge>"
	elif [ -f "${TOPLEVEL}/.git/CHERRY_PICK_HEAD" ]
	then MODE="<cherry-pick>"
	elif [ -f "${TOPLEVEL}/.git/BISECT_LOG" ]
	then MODE="<bisect>"
	fi
	echo -n '('${MODE}${BRANCH}${DIRTY}')'
}

function parse_svn_revision() {
	# If this environment variable is set, we skip this part.
	[ "${DISABLE_SVN_PROMPT}" = "" ] || return
	[ -d .svn ] || return
	local DIRTY REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
	[ "$REV" ] || return
	[ "$(svn st | grep -e '^ \?[M?] ')" ] && DIRTY='*'
	echo "(r$REV$DIRTY)"
}

if [ `whoami` = root ]
then
	PS1_PREFIX='\[\033[1;31m\]\h:\[\033[1;34m\]\W \[\033[33m\]'
	PS1_SUFFIX='\[\033[0m\]\$ '
else
	PS1_PREFIX='\[\033[1;32m\]\h:\[\033[1;34m\]\W \[\033[33m\]'
	PS1_SUFFIX='\[\033[0m\]\$ '
fi

PS1="$PS1_PREFIX"
( which git 2> /dev/null > /dev/null ) && PS1="$PS1"'$(parse_git_branch)'
( which svn 2> /dev/null > /dev/null ) && PS1="$PS1"'$(parse_svn_revision)'
PS1="$PS1$PS1_SUFFIX"


