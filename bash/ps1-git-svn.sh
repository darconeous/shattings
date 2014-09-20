#!/bin/bash
#
# Copyright (c) 2012, Jochen Issing <iss@nesono.com>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the <organization> nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# -------------------------------------------------------------------------------
#
# This file has been heavily modified by Robert Quattlebaum <darco@deepdarc.com>.
#
# The original version of this file can be found here:
#
#  * <https://github.com/nesono/nesono-bin/blob/master/bashtils/ps1status>
#

# Prompt setup, with SCM status
function parse_git_branch() {
	local DIRTY STATUS BRANCH MODE TOPLEVEL

	# If this environment variable is set, we skip this part.
	[ "${DISABLE_GIT_PROMPT}" = "" ] || return

	PROMPT_TYPE=$(git config gitprompt.type)
	[ "$PROMPT_TYPE" = "0" ] && return
	[ "$PROMPT_TYPE" = "disabled" ] && return
	[ "$PROMPT_TYPE" = "off" ] && return
	[ "$PROMPT_TYPE" = "no" ] && return
	[ "${PROMPT_TYPE:0:1}" = "f" ] && return
	[ "${PROMPT_TYPE:0:1}" = "F" ] && return

	TOPLEVEL="$(git rev-parse --show-toplevel 2>/dev/null)"
	[ "$TOPLEVEL" = "" ] && return
	[ "$TOPLEVEL" = "/.git" ] && return
	[ "$TOPLEVEL" = "/" ] && return
	[ "$TOPLEVEL" = "--show-toplevel" ] && {
		# Older versions of GIT.
		TOPLEVEL="$(git rev-parse --show-cdup 2>/dev/null)./"
	}

	BRANCH="$(sed -n '/ref: /!{a\
<detached>
};/ref: /{s/ref: //;s:^refs/heads/::;p;};' "$TOPLEVEL"/.git/HEAD)"

	if [ "$BRANCH" = '<detached>' ]
	then
		branch="<$(exec-for 1 git describe --always)>" && BRANCH="$branch"
	fi

	#Too slow!
	#BRANCH="$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')"

	[ "${PROMPT_TYPE}" != "simple" ] && {
		STATUS=$(exec-for 1 git status --porcelain 2>/dev/null)
		[ $? -eq 128 ] && return
		[ -z "$(echo "$STATUS" | grep -e '^ [RDMA]')"    ] || DIRTY="*"
		[ -z "$(echo "$STATUS" | grep -e '^?? ')"    ] || DIRTY="${DIRTY}?"
		[ -z "$(echo "$STATUS" | grep -e '^[RMDA]')" ] || DIRTY="${DIRTY}+"
		[ -z "$(git stash list)" ]                    || DIRTY="${DIRTY}^"
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
	}

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
	PS1_PREFIX='\[\033[0;1;31m\]\h:\[\033[1;34m\]\W \[\033[0;1m\]'
	PS1_SUFFIX='\[\033[0m\]\$ '
else
	PS1_PREFIX='\[\033[0;1;32m\]\h:\[\033[1;34m\]\W \[\033[0;1m\]'
	PS1_SUFFIX='\[\033[0m\]\$ '
fi

PS1="$PS1_PREFIX"
( which git 2> /dev/null > /dev/null ) && PS1="$PS1"'$(parse_git_branch)'
( which svn 2> /dev/null > /dev/null ) && PS1="$PS1"'$(parse_svn_revision)'
PS1="$PS1$PS1_SUFFIX"


