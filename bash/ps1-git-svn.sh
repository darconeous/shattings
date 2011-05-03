#!/bin/bash

# Original version of this file:
# https://github.com/nesono/nesono-bin/blob/master/bashtils/ps1status

# Prompt setup, with SCM status
function parse_git_branch() {
  local DIRTY STATUS
  STATUS=$(git status --porcelain 2>/dev/null)
  [ $? -eq 128 ] && return
  [ -z "$(echo "$STATUS" | grep -e '^ [RDMA]')"    ] || DIRTY="*"
  [ -z "$(echo "$STATUS" | grep -e '^?? ')"    ] || DIRTY="${DIRTY}?"
  [ -z "$(echo "$STATUS" | grep -e '^[RMDA]')" ] || DIRTY="${DIRTY}+"
  [ -z "$(git stash list)" ]                    || DIRTY="${DIRTY}^"
  echo "($(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$DIRTY)"
}

function parse_svn_revision() {
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


