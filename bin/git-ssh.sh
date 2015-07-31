#!/bin/sh

ssh_command="`git config core.gitssh || echo ssh`"

$ssh_command "$@"
