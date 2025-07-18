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
if [ -f /usr/share/bash-completion/completions/git ] ; then
#     # ubuntu 22.4
    source /usr/share/bash-completion/completions/git
#     # to disable equal to upstream (develop=)
#     # edit /usr/lib/git-core/git-sh-prompt
#     # "0      0") # equal to upstream
#     #        p="" ;;
#     #        #p="=" ;;
else
    source ~/.git-completion.bash
fi

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
    # if [ ! -z $INSIDE_WSL ] ; then
    #     # very slow in windows filesystems: /c/...
    # it is now fast: WSL2 January 2025
    #     dir=`realpath .`
    #     if [ ${dir::3} == "/c/" ] || [ ${dir::7} == "/mnt/c/" ] ; then
    #         return
    #     fi
    # fi

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
    # add_prompt_conda # useless
    add_prompt_git
    add_prompt_wdir
    add_prompt_emoji
}
set_prompt_remote()
{
    export GITBRANCH="λ"
    PS1=""
    # git prompt : hide if it's a remote connection and it's the home repository
    # because we're not logged in to commit-push
    if [ "$(__git rev-parse --show-toplevel)" != "$HOME" ] ; then
        add_prompt_git
    fi
    add_prompt_wdir
    PS1+=" ${lightpurple}[\h]${reset}"
    add_prompt_emoji
}
set_prompt_nospecialchars()
{
    PS1=""
    GITBRANCH="" # lambda greek letter breaks conda on mingw
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
        if [ "$MYPC" == "0" ] && [ "$DISPLAY" != ":0" ] ; then
            PROMPT_COMMAND=set_prompt_remote
        else
            PROMPT_COMMAND=set_prompt_all
        fi
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
alias grep='grep --color=auto'
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
alias gdu='gd -U0'
gdcat()
{
    git diff --color=always --ignore-space-change $*| cat
}
alias gc='git commit'
alias ga='git add'
alias gpush='git push'
alias gpull='git pull'
alias g='git'
# git hide https://henrebotha.github.io/2017/08/30/hiding-local-file-changes-from-git.html
alias ghide='git update-index --skip-worktree'
alias gunhide='git update-index --no-skip-worktree'
alias ghidden='git ls-files -v . | grep ^S'
alias explo='explorer .'
alias vlcminview='vlc --qt-minimal-view'
alias sema='sudo emacs -nw'
alias Youtube-audio='youtube-dl -f 140 --embed-thumbnail'
alias zz-youtube-audio='Youtube-audio --output="ZZ %(title)s.%(ext)s"'
# youtube-audio alternative : -x --audio-format m4a INSTEAD OF -f 140'
alias time='TIME="Time %E" time'
alias vim='vim -c startinsert'
alias bc='bc -l'
command -v killall > /dev/null
if [ $? == 1 ]
then
    # killall not provided by system
    killall()
    {
        if [ $# != 1 ]
        then
            echo "Usage: $(basename $0) <name of program to kill>"
            exit 1
        fi
        for pid in $(pidof $1)
        do
            kill $pid
        done
    }
fi

if [ -z $CPUCOUNT ] ; then
    # CPUCOUNT=`grep ^processor /proc/cpuinfo|wc -l`
    CPUCOUNT=`nproc`
    export MAKEFLAGS="-j$CPUCOUNT"
fi

if [ -z "$EDITOR" ] ; then
    if echo $UNAMEMACHINE | grep -q aarch && [ $CPUCOUNT -le 4 ] ; then
        # slow machine, pi4
        EDITOR='vim -c startinsert'
    else
        EDITOR='emacs -nw -q -l $HOME/.emacs.d/git.editor.settings.el '
    fi
fi
export GIT_EDITOR=$EDITOR

# git prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
#GIT_PS1_SHOWSTASHSTATE=1 # not interesting when it's always true
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
        echo "pkgget mingw-w64-x86_64-source-highlight"
        # echo "pkgget mingw-w64-clang-x86_64-source-highlight"
        # echo "or if broken, copy from old working msys:"
        # echo "mkdir -p ~/.local/MinGW/share ~/.local/MinGW/bin"
        # echo "cp -ar ./mingw64/bin/*source-highlight* ~/.local/MinGW/bin/"
        # echo "cp -ar ./mingw64/share/source-highlight/ ~/.local/MinGW/share/"
        # echo "for i in gcc_s_seh-1 stdc++-6 winpthread-1 boost_regex-mt icuuc67 icudt67; do cp -ar ./mingw64/bin/lib\$i.dll ~/.local/MinGW/bin/; done"
    else
        echo "pkgget source-highlight"
    fi
fi
LESS+=" -F" # do not paginate if shorter than one screen
LESS+=" -I" # search is case insensitive

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
        echo Usage : cgdbattachto NameOfProgram
    else
        cgdb --eval-command="attach $(pidof $1)"
    fi
}
jpegsmaller_onefile()
{
    convert -quality 80 -resize 50% "$1" "$2"
}
jpegsmaller()
{
    echo "converting in directory $PWD/$outdir"
    echo -n "... "
    outdir="jpegsmaller"
    mkdir -p $outdir
    count=0
    for extension in jpg jpeg JPG JPEG
    do
        if [ $(ls *.$extension 2>/dev/null | wc -l) -gt 0 ]
        then
            for i in *.$extension
            do
                count=$(expr $count + 1)
                convert -quality 90 -resize 75% "$i" "$outdir/$i"
            done
        fi
    done

    if [ $count == 0 ]
    then
        echo "No jpg found in $PWD"
    else
        echo "converted $count files"
    fi
}
findsimilar()
{
    # https://stackoverflow.com/a/53592290
    find -type f -print0 | xargs -0 md5sum | sort -k1,32 | uniq -w32 -D
}
removesimilar()
{
    # https://unix.stackexchange.com/a/192712
    find -type f -print0 | xargs -0 md5sum | sort | awk 'BEGIN{lasthash = ""} $1 == lasthash {print $2} {lasthash = $1}' | xargs echo rm
}
findsamename()
{
    # https://unix.stackexchange.com/a/468461
    find -type f -print0 |     awk -F/ 'BEGIN { RS="\0" } { n=$NF } k[n]==1 { print p[n]; } k[n] { print $0 } { p[n]=$0; k[n]++ }'
}
FFMPEG1080="-filter:v scale=-1:1080 -b:v 10000k"
ffmpeg1080p()
{
    ffmpeg -i "$1" $FFMPEG1080 "$2" $3 $4 $5 $6 $7 $8 $9
    ### for cropping vertical video from 1080p:
    # -vf "crop=700:1080:610:0"
    ### for smaller file size, 30 seconds is 10 megabytes like this:
    # -filter:v scale=-1:720 -b:v 2300k
    ### to convert and HDR capture for sharing on apps that fail the color space:
    # -filter_complex "[0:0]scale=1920:-8:flags=lanczos,setsar=1:1,zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p[v]" -map "[v]"
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
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# TERM needed for emacs-nox to work with colored themes
if [ "$TERM" != "cygwin" ]
then
    export TERM=xterm-256color
fi

# locale
# next 2 lines are broken in WSL
# export LC_CTYPE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# watch interval
export WATCH_INTERVAL=1

# add BATCAT alias
command -v batcat >/dev/null
if [ $? == 0 ]
then
    alias bat=batcat
    alias batjson='bat -l json --theme "Monokai Extended"'
    alias bathtml='bat -l html --theme "Monokai Extended"'
fi

# do not remember the dangerous command(s)
export HISTIGNORE='rm *:*password*'
export HISTCONTROL=erasedups

# # hide python cache
# # to be removed, because this new name of the directory is not git-ignored by most projects
# export PYTHONPYCACHEPREFIX=.pycache

# add current dir . at start
if [ ${PATH::2} != ".:" ] ; then
    PATH=".:""$PATH"
fi

# add ~/bin to path
if [ -d ~/bin ] ; then
    add_path ~/bin
fi

if [ -f ${HOME}/.bash_local ] ; then
    source ${HOME}/.bash_local
fi

if [ -n "$INSIDE_WSL" ]
then
    wsl_get_win_env_var()
    {
        cmd.exe /c echo %$1% 2>/dev/null | dos2unix
    }
    wsl_install_my_setup()
    {
        WSLCONFIGPATH=$(wsl_get_win_env_var USERPROFILE | sed -e 's+\\+/+g' -e 's+C:+/c+')
        WSLCONFIGPATH+="/.wslconfig"

        echo ">>> now in $WSLCONFIGPATH >>>"
        (cat ~/.wslconfig.custom; echo "") | tee $WSLCONFIGPATH | grep -v ^#

        WSLCONFIGPATH=/etc/wsl.conf
        echo ">>> now in $WSLCONFIGPATH >>>"
        (cat ~/.wsl.conf.custom; echo "") | sudo tee $WSLCONFIGPATH | grep -v ^#

        # # PYTHONPYCACHEPREFIX is needed for emacs calling wsl python
        # echo ">>> setx PYTHONPYCACHEPREFIX WSLENV >>>"
        # setx.exe PYTHONPYCACHEPREFIX .pycache | dos2unix | grep -v '^$'
        # setx.exe WSLENV $(wsl_get_win_env_var WSLENV):PYTHONPYCACHEPREFIX | dos2unix | grep -v '^$'

    }
    wslout()
    {
        # add .exe to the first argument and run
        cmd="${1}.exe"
        shift
        "$cmd" "$@"
    }
    wsloutpython()
    {
        wslout python "$@"
    }
    pingme()
    (
        notify-wsl.sh
    )
else
    # not inside WSL
    pingme()
    (
        text="You've been pinged"
        notify-send "$text"
        zenity --info --text "$text"
    )
fi
