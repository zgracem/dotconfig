# -----------------------------------------------------------------------------
# paths
# -----------------------------------------------------------------------------

# get a reliable base path
# export SYSPATH="$(command -p getconf PATH 2>/dev/null)"
# : ${SYSPATH:=/usr/bin:/bin:/usr/sbin:/sbin}

# base paths
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:$PATH
export MANPATH=/usr/share/man:/usr/man:$MANPATH
export INFOPATH=/usr/share/info:$INFOPATH
export CDPATH=.:$HOME

# /usr/local
PATH=/usr/local/bin:/usr/local/sbin:$PATH
MANPATH=/usr/local/share/man:$MANPATH
INFOPATH=/usr/local/share/info:$INFOPATH

# -----------------------------------------------------------------------------
# development
# -----------------------------------------------------------------------------

# Ruby (see also bashrc.d/rubygems.bash)
export RBENV_ROOT="$HOME/.rbenv"

if [[ -d $RBENV_ROOT ]]; then
    export RBENV_ROOT
    PATH=$RBENV_ROOT/bin:$PATH
    eval "$(rbenv init -)"
else
    unset -v RBENV_ROOT
fi

# go-lang (see also bashrc.d/golang.bash)
case $HOSTNAME in
    Athena)
        PATH=$PATH:/usr/local/opt/go/libexec/bin
        ;;
    *.atco.com)
        PATH=$PATH:/opt/go/bin
        ;;
esac

# -----------------------------------------------------------------------------
# OS X
# -----------------------------------------------------------------------------

# Homebrew (see also bashrc.d/homebrew.bash)
if [[ -x /usr/local/bin/brew ]]; then
    # GNU coreutils
    PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
    MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
    INFOPATH=/usr/local/opt/coreutils/share/info:$INFOPATH

    # GNU sed
    PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
    MANPATH=/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH
    INFOPATH=/usr/local/opt/gnu-sed/share/info:$INFOPATH

    # GNU tar
    PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH

    # OpenSSL
    PATH=/usr/local/opt/openssl/bin:$PATH
    MANPATH=/usr/local/opt/openssl/share/man:$MANPATH

    # ncurses
    PATH=/usr/local/opt/ncurses/bin:$PATH
    MANPATH=/usr/local/opt/ncurses/share/man:$MANPATH
fi

# Xcode
if [[ -x /usr/bin/xcode-select ]]; then
    case $HOSTNAME in
        Athena|Minerva)
            DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
            ;;
        Erato)
            DEVELOPER_DIR="/Library/Developer/CommandLineTools"
            ;;
        Hiroko)
            DEVELOPER_DIR="/Developer"
            ;;
        *)
            DEVELOPER_DIR=$(xcode-select --print-path)
            ;;
    esac

    export DEVELOPER_DIR

    darwin_ver=$(uname -r)

    if (( ${darwin_ver%%.*} >= 15 )); then
        # PATH=$PATH:$DEVELOPER_DIR/usr/bin
        # PATH=$PATH:$DEVELOPER_DIR/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/bin
        # PATH=$PATH:$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/bin
        MANPATH=$MANPATH:$DEVELOPER_DIR/usr/share/man
        MANPATH=$MANPATH:$DEVELOPER_DIR/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/share/man
        MANPATH=$MANPATH:$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/share/man
    else
        PATH=$DEVELOPER_DIR/usr/share/man:$PATH
        MANPATH=$DEVELOPER_DIR/usr/bin:$MANPATH
    fi

    unset -v darwin_ver
fi

# calibre
PATH=$PATH:$HOME/Applications/calibre.app/Contents/MacOS

# -----------------------------------------------------------------------------
# cygwin
# -----------------------------------------------------------------------------

# gcc tools
PATH=$PATH:/opt/gcc-tools/bin
MANPATH=$MANPATH:/opt/gcc-tools/epoch2/share/man
INFOPATH=$INFOPATH:/opt/gcc-tools/epoch2/share/info

# add Windows' %PATH% if available (cygwin)
if [[ -n $ORIGINAL_PATH ]]; then
    PATH=$PATH:$ORIGINAL_PATH
fi

# -----------------------------------------------------------------------------
# ~
# -----------------------------------------------------------------------------

PATH=$HOME/bin:$HOME/opt/bin:$HOME/opt/go/bin:$PATH
MANPATH=$HOME/share/man:$HOME/opt/share/man:$MANPATH
INFOPATH=$HOME/share/info:$HOME/opt/share/info:$INFOPATH

# -----------------------------------------------------------------------------
# remove nonexistent directories
# -----------------------------------------------------------------------------

fixpath()
{
    # The input, a colon-separated list, is split by setting IFS to a colon
    # and using an unquoted $@ in the `for` loop. Each directory is checked to
    # ensure that it isn't already in the PATH-in-progress, and that it exists
    # at all; if both, it's appended to the P-in-p, w/ a leading colon if
    # necessary. Once complete, it prints the new PATH and returns 0.

    local d p IFS=:

    for d in $@; do
        [[ ! :$p: =~ :$d: ]] && [[ -d $d ]] && p+="${p:+:}$d"
    done

    printf "$p"
}

PATH=$(    fixpath "$PATH")
MANPATH=$( fixpath "$MANPATH")
INFOPATH=$(fixpath "$INFOPATH")

unset -f fixpath

return 0
