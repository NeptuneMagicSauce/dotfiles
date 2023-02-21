#!/bin/sh

# test sanity
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
source ~/.bash_work   # pro work specific

# completion : git, docker, ...
# if [ -f /usr/share/bash-completion/bash_completion ] ; then
#     # ubuntu 22.4
#     source /usr/share/bash-completion/bash_completion
#     # to disable equal to upstream (develop=)
#     # edit /usr/lib/git-core/git-sh-prompt
#     # "0      0") # equal to upstream
#     #        p="" ;;
#     #        #p="=" ;;
# else
    source ~/.git-completion.bash
# fi

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
    if [ ! -z $INSIDE_WSL ] ; then
        # very slow in windows filesystems: /c/...
        dir=`realpath .`
        if [ ${dir::3} == "/c/" ] ; then
            return
        fi
    fi

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
    elif [ $UNAMEOS == "MinGW" ] ; then
        PROMPT_COMMAND=set_prompt_all
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
alias pp='cd ../..'
alias ppp='cd ../../..'
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
# alias gs='~/.git-status.sh' # shadows command gs from package ghostscript
alias gss='git status'
alias gd='git diff -w'
gdcat()
{
    git diff --color=always --ignore-space-change $*| cat
}
alias gc='git commit'
alias ga='git add'
alias gpush='git push'
alias gpull='git pull'
alias g='git'
alias explo='explorer .'
alias vlcminview='vlc --qt-minimal-view'
alias sema='sudo emacs -nw'
alias Youtube-audio='youtube-dl -f 140 --embed-thumbnail'
alias zz-youtube-audio='Youtube-audio --output="ZZ %(title)s.%(ext)s"'
# youtube-audio alternative : -x --audio-format m4a INSTEAD OF -f 140'
alias time='TIME="Time %E" time'
alias vim='vim -c startinsert'

if [ -z $CPUCOUNT ] ; then
    # CPUCOUNT=`grep ^processor /proc/cpuinfo|wc -l`
    CPUCOUNT=`nproc`
    export MAKEFLAGS="-j$CPUCOUNT"
fi

export GIT_EDITOR=$EDITOR
# git prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

# less syntax highlighting
command -v source-highlight > /dev/null
if [ $? == 0 ] ; then
    # if [ $UNAMEOS == Cygwin ] || [ $UNAMEOS == Msys ] ; then
    export LESSOPEN="| source-highlight --failsafe --infer-lang -f esc --style-file=$HOME/.syntax-highlight.style -i %s"
    export LESS=-R
    # doc says this:
    # export LESSOPEN="| src-hilite-lesspipe.sh %s"
else
    echo "missing source-highlight"
    if [ $UNAMEOS == MinGW ] ; then
        echo "pkgget mingw-w64-clang-x86_64-source-highlight"
        echo "or if broken, copy from old working msys:"
        echo "mkdir -p ~/.local/MinGW/share ~/.local/MinGW/bin"
        echo "cp -ar ./mingw64/bin/*source-highlight* ~/.local/MinGW/bin/"
        echo "cp -ar ./mingw64/share/source-highlight/ ~/.local/MinGW/share/"
        echo "for i in gcc_s_seh-1 stdc++-6 winpthread-1 boost_regex-mt icuuc67 icudt67; do cp -ar ./mingw64/bin/lib\$i.dll ~/.local/MinGW/bin/; done"
    else
        echo "pkgget source-highlight"
    fi
fi
LESS+=" -F" # do not paginate if shorter than one screen

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
# not supported by Windows Terminal
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

# watch interval
export WATCH_INTERVAL=1

# add BATCAT alias
command -v batcat >/dev/null && alias bat=batcat

# do not remember the dangerous command(s)
export HISTIGNORE='rm *'

# add current dir . at start
if [ ${PATH::2} != ".:" ] ; then
    PATH=".:""$PATH"
fi
