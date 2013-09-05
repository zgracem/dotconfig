# -----------------------------------------------------------------------------
# ~zozo/.config/bash/paths
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# get a reliable path prefix
SYSPATH="$(command -p getconf PATH 2>/dev/null)"
: ${SYSPATH:="/usr/bin:/bin:/usr/sbin:/sbin"}

PATH=$SYSPATH:/usr/games
MANPATH=/usr/share/man:/usr/man
INFOPATH=/usr/share/info

# /usr/local
[[ -d /usr/local ]] && {
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
    MANPATH=/usr/local/share/man:$MANPATH
    INFOPATH=/usr/local/share/info:$INFOPATH
}

# Fink
[[ -d /sw ]] && {
    PATH=/sw/bin:/sw/sbin:$PATH
    MANPATH=/sw/share/man:$MANPATH
    INFOPATH=/sw/share/info:$INFOPATH
}

# MacPorts
[[ -d /opt/local ]] && {
    PATH=/opt/local/bin:/opt/local/sbin:$PATH
    MANPATH=/opt/local/share/man:$MANPATH
    INFOPATH=/opt/local/share/info:$INFOPATH
}

# GNU tools (from MacPorts)
[[ -d /opt/local/libexec/gnubin ]] && {
    PATH=/opt/local/libexec/gnubin:$PATH
}

# GNU tools (from Homebrew)
[[ -x /usr/local/bin/brew ]] && {
    [[ -d $(brew --prefix coreutils)/libexec/gnubin ]] && {
        PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
    }

    [[ -d $(brew --prefix gnu-sed)/libexec/gnubin ]] && {
        PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"
        MANPATH="$(brew --prefix gnu-sed)/libexec/gnuman:$MANPATH"
    }
}

# X11 apps
[[ -d /usr/X11 ]] && {
    PATH=$PATH:/usr/X11/bin
    MANPATH=$MANPATH:/usr/X11/share/man
}

[[ -d /usr/X11R6 ]] && {
    PATH=$PATH:/usr/X11R6/bin
    MANPATH=$MANPATH:/usr/X11R6/share/man
}

# gcc tools
[[ -d /opt/gcc-tools/bin ]] && {
    PATH=$PATH:/opt/gcc-tools/bin
    MANPATH=$MANPATH:/opt/gcc-tools/epoch2/share/man
    INFOPATH=$INFOPATH:/opt/gcc-tools/epoch2/share/info
}

# ~/bin
[[ -d $HOME/bin ]] && {
    PATH=$HOME/bin:$PATH
}

[[ -d $HOME/share/man ]] && {
    MANPATH=$HOME/share/man:$MANPATH
}

# remove duplicates in $PATH while preserving order
# https://sites.google.com/site/jdisnard/etc-skel/dot-profile
# PATH=$(echo $PATH | awk -F: '{ for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); } }')

# -----------------------------------------------------------------------------

CDPATH=.:$HOME      # also look in ~ when cd'ing

# setup mail
[[ -r /var/mail/$USER ]] && {
    MAILPATH=/var/mail/$USER?'New mail in $_'
}

# Python
[[ -e /usr/local/lib/python2.7/site-packages ]] && {
    PYTHONPATH=/usr/local/lib/python2.7/site-packages
}

export {CD,MAIL,MAN,INFO,PYTHON,}PATH
