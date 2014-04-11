# -----------------------------------------------------------------------------
# ~zozo/.config/bash/paths
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# only run if we need to
[[ -n $SYSPATH ]] &&
    return

# get a reliable path prefix
SYSPATH="$(command -p getconf PATH 2>/dev/null)"
: ${SYSPATH:="/usr/bin:/bin:/usr/sbin:/sbin"}

PATH=$SYSPATH:/usr/games
MANPATH=/usr/share/man:/usr/man
INFOPATH=/usr/share/info

# /usr/local
if [[ -d /usr/local ]]; then
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
    MANPATH=/usr/local/share/man:$MANPATH
    INFOPATH=/usr/local/share/info:$INFOPATH
fi

# GNU tools (from Homebrew)
if [[ -x /usr/local/bin/brew ]]; then
    core_prefix="$(brew --prefix coreutils)"
    sed_prefix="$(brew --prefix gnu-sed)"
    
    if [[ -d $core_prefix ]]; then
        PATH=$core_prefix/libexec/gnubin:$PATH
        MANPATH=$core_prefix/libexec/gnuman:$MANPATH
        INFOPATH=$core_prefix/share/info:$INFOPATH
    fi

    if [[ -d $sed_prefix ]]; then
        PATH=$sed_prefix/libexec/gnubin:$PATH
        MANPATH=$sed_prefix/libexec/gnuman:$MANPATH
        INFOPATH=$sed_prefix/share/info:$INFOPATH
    fi

    unset {core,sed}_prefix
fi

# # X11 apps
# if [[ -d /usr/X11 ]]; then
#     PATH=$PATH:/usr/X11/bin
#     MANPATH=$MANPATH:/usr/X11/share/man
# fi

# if [[ -d /usr/X11R6 ]]; then
#     PATH=$PATH:/usr/X11R6/bin
#     MANPATH=$MANPATH:/usr/X11R6/share/man
# fi

# gcc tools (cygwin)
if [[ -d /opt/gcc-tools/bin ]]; then
    PATH=$PATH:/opt/gcc-tools/bin
    MANPATH=$MANPATH:/opt/gcc-tools/epoch2/share/man
    INFOPATH=$INFOPATH:/opt/gcc-tools/epoch2/share/info
fi

# OpenSSL
if [[ -d /usr/ssl/man ]]; then
    MANPATH=$MANPATH:/usr/ssl/man
fi

# ~/bin
if [[ -d $HOME/bin ]]; then
    PATH=$HOME/bin:$PATH
fi

if [[ -d $HOME/share/man ]]; then
    MANPATH=$HOME/share/man:$MANPATH
fi

if [[ -d $HOME/share/info ]]; then
    INFOPATH=$HOME/share/info:$INFOPATH
fi

# remove duplicates in $PATH while preserving order
# https://sites.google.com/site/jdisnard/etc-skel/dot-profile
# PATH=$(echo $PATH | awk -F: '{ for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); } }')

# -----------------------------------------------------------------------------

CDPATH=.:$HOME      # also look in ~ when cd'ing

# Python
if [[ -d /usr/local/lib/python2.7/site-packages ]]; then
    PYTHONPATH=/usr/local/lib/python2.7/site-packages
fi

export {,CD,MAN,INFO,PYTHON}PATH
