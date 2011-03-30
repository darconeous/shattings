#!/bin/bash

# Prompt setup, with SCM status
function parse_git_branch() {
  local DIRTY STATUS
  STATUS=$(git status --porcelain 2>/dev/null)
  [ $? -eq 128 ] && return
  [ -z "$(echo "$STATUS" | grep -e '^ M')"    ] || DIRTY="*"
  [ -z "$(echo "$STATUS" | grep -e '^[MDA]')" ] || DIRTY="${DIRTY}+"
  [ -z "$(git stash list)" ]                    || DIRTY="${DIRTY}^"
  echo "($(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')$DIRTY)"
}

function parse_svn_revision() {
  local DIRTY REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
  [ "$REV" ] || return
  [ "$(svn st | grep -e '^ \?[M?] ')" ] && DIRTY='*'
  echo "(r$REV$DIRTY)"
}

# add this line to your ~/.bashrc for git/svn status display in bash prompt
#PS1='\h:\W$(parse_git_branch)$(parse_svn_revision) \$ '
#
# add one of these lines to your ~/.bashrc for git/svn status display in bash prompt with colors
# normal users
PS1='\[\033[1;32m\]\h:\[\033[1;34m\]\W \[\033[33m\]$(parse_git_branch)$(parse_svn_revision)\[\033[0m\] '
# root user
#PS1='\[\033[31m\]\h:\[\033[1;34m\]\W \[\033[33m\]$(parse_git_branch)$(parse_svn_revision)\[\033[0m\] '
