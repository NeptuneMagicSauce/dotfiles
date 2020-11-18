#!/bin/sh
source ~/.bash_git
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
value=`__git_ps1`
if [ ! -z "$value" ] ; then
    echo "$value "
fi
