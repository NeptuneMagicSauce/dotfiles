#!/bin/sh
# comment
command -v ls > /dev/null
if [ $? == 1 ] ; then
    echo "ls is not found in path"
fi

# source other files
source ~/.bash_prompt # colors $orange
source ~/.bash_emoji  # get_random_emoji()
source ~/.bash_git    # __git_ps1()
source ~/.bash_svn    # svnDiff()
source ~/.bash_perso  # for my machine
source ~/.git-completion.bash

# customisations / user choices
PROMPT_INCLUDE_GIT=1
PROMPT_COLOR_GIT=$lightblue # $lightpurple
PROMPT_COLOR_DIRECTORY=$orange
PROMPT_COLOR_CONDA=$green

# set prompt PS1
# for customisation, see color codes in ~/.bash_prompt
add_prompt_wdir()
{
    PS1+="\[$PROMPT_COLOR_DIRECTORY\]\\w"
    PS1+="\[$reset\]"
    # last command return code
    # if [[ $? == 0 ]]; then
        # PS1+="\[$PROMPTRETOK\] "
    # else
        # PS1+="\[$PROMPTRETFAIL\] "
    # fi

    # OS
    # PS1+="$PROMPTOS"
}
add_prompt_conda()
{
    if [ "$CONDA_PROMPT_MODIFIER" != "(base) " ] ; then
        PS1+="\[$PROMPT_COLOR_CONDA\]"
        PS1+="$CONDA_PROMPT_MODIFIER"
    fi
}
add_prompt_git()
{
    GITVALUE=`echo $(__git_ps1)`
    if [ ! -z "$GITVALUE" ]; then
        PS1+="\[$PROMPT_COLOR_GIT\]$GITBRANCH$GITVALUE "
    fi
}
add_prompt_emoji()
{
    if [ -n "$INSIDE_EMACS" ]; then
        PS1+=" $ "
    else
        PS1+=" `get_random_emoji` "
    fi
}
set_prompt_all() # slow with msys and cygwin
{
    PS1=""
    add_prompt_conda
    add_prompt_git
    add_prompt_wdir
    add_prompt_emoji
}
set_prompt_nospecialchars()
{
    PS1=""
    GITBRANCH="" # lambda greek letter breaks conda on minw
    add_prompt_conda
    add_prompt_git
    add_prompt_wdir
    PS1+=" "
}
set_prompt_fast()
{
    PS1=""
    add_prompt_wdir
    add_prompt_emoji
}
if [ $PROMPT_INCLUDE_GIT == 1 ] ; then
    if [ $UNAMEOS == "GNU/Linux" ] ; then
        PROMPT_COMMAND=set_prompt_all
    elif [ $UNAMEOS == "Msys" ] ; then
        PROMPT_COMMAND=set_prompt_nospecialchars
    else
        PROMPT_COMMAND=set_prompt_fast
    fi
else
    PROMPT_COMMAND=set_prompt_fast
fi

# aliases
alias ls='ls --color -B'
alias l='ls -loh'
alias la='l -a'
alias llast='l -tr'
alias p='cd ..'
alias b='cd -'
alias grep='grep --color=always'
alias du='du -shc'
alias df='df -h'
alias sort='sort -h'
alias bashreload='source ~/.bashrc'
alias bahsreload='bashreload'
alias lf='l|grep -i'
alias wd='pwd'
alias untar='tar xf'
alias gerp='grep'
alias grpe='grep'
alias mydate='date +%Y.%m.%d.%Hh.%Mm'
alias ema='emacs -nw'
alias bahsconfig='bashconfig'
alias emaconfig='ema ~/.emacs'
alias gs='~/.git-status.sh'
alias gss='git status'
alias gd='git diff --ignore-space-change'
alias gdcat='git diff --color=always --ignore-space-change| cat'
alias gc='git commit'
alias ga='git add'
alias gpush='git push'
alias gpull='git pull'
alias g='git'
alias explo='explorer .'
alias vlcminview='vlc --qt-minimal-view'
alias sema='sudo emacs -nw'
alias Youtube-audio='youtube-dl -f 140 --embed-thumbnail'
# cd $INCOMING/iTunes/IPOD/;
alias zz-youtube-audio='Youtube-audio --output="ZZ %(title)s.%(ext)s"'
# youtube-audio alternative : -x --audio-format m4a INSTEAD OF -f 140'

if [ -z $CPUCOUNT ] ; then
    CPUCOUNT=`grep ^processor /proc/cpuinfo|wc -l`
    export MAKEFLAGS="-j$CPUCOUNT"
fi

export GIT_EDITOR=$EDITOR
# git prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

# less syntax highlighting
which source-highlight 2>/dev/null 1>&2
if [ $? == 0 ] ; then
    # if [ $UNAMEOS == Cygwin ] || [ $UNAMEOS == Msys ] ; then
    export LESSOPEN="| source-highlight --failsafe --infer-lang -f esc --style-file=$HOME/.syntax-highlight.style -i %s"
    # elif [ $UNAMEOS == GNU/Linux ] ; then
    # export LESSOPEN="| src-hilite-lesspipe.sh %s"
    # fi
    export LESS=-R
fi

# functions
ff()
{
    find "$1" -iname "*$2*"
}
ccat() # cat in color
{
    less "$@" | cat
}
ccatn() # cat in color with line numbers
{
    less "$@" | cat -n
}
randpassword()
{
    # </dev/urandom tr -dc 'azertqsdfgwxcvAZERTQSDFGWXCV12345' | head -c 8 ; echo "   <--- left-hand only"
    </dev/urandom tr -dc A-Z | head -c 4
    </dev/urandom tr -dc a-z | head -c 4
    </dev/urandom tr -dc 0-9 | head -c 4
    < /dev/urandom tr -dc "!@#$%^\&*\(\)\-_=+[]{}" | head -c 4
    echo ""
}
settitle ()
{
    echo -ne "\033]2;$@\a\033]1;$@\a";
}

bashconfig()
{
    ema ~/.bashrc
    echo 'run this ->'
    echo 'bashreload'
}

cgdbattachto()
{
    if [ -z $1 ] ; then
        echo Usage : cgdbattachto PID-value
    else
        cgdb --eval-command="attach $1"
    fi
}

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# man pages colors https://unix.stackexchange.com/a/147
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# TERM needed for emacs-nox to work with colored themes
if [ "$TERM" != "cygwin" ]
then
    export TERM=xterm-256color
fi

# locale
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# add VLC to path
if [ -x "/c/Program Files/VideoLAN/VLC/vlc.exe" ]
then
    command -v vlc > /dev/null
    if [ $? == 1 ]
    then
        PATH=$PATH:"/c/Program Files/VideoLAN/VLC/"
    fi
fi

if [ $HOSTNAME == "xoaltecuhtli" ]; then
    # . "/usr/etc/profile.d/conda.sh"  # old location
    . "/home/rlacroix/miniconda3/etc/profile.d/conda.sh"
fi

# add BATCAT alias
command -v batcat >/dev/null && alias bat=batcat

# add ~/local to path
if [ -d ~/local/bin ] ; then
    export PATH=~/local/bin:$PATH
fi
