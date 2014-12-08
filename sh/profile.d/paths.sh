PATH=/usr/bin:/bin:/usr/sbin:/sbin
MANPATH=/usr/share/man:/usr/man
INFOPATH=/usr/share/info
CDPATH=.:$HOME

# /usr/local
if test -d /usr/local; then
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
    MANPATH=/usr/local/share/man:$MANPATH
    INFOPATH=/usr/local/share/info:$INFOPATH
fi

# GNU tools (from Homebrew)
if test -x /usr/local/bin/brew; then
    core_prefix="`brew --prefix coreutils`"
    sed_prefix="`brew --prefix gnu-sed`"
    tar_prefix="`brew --prefix gnu-tar`"

    if test -d $core_prefix; then
        PATH=$core_prefix/libexec/gnubin:$PATH
        MANPATH=$core_prefix/libexec/gnuman:$MANPATH
        INFOPATH=$core_prefix/share/info:$INFOPATH
    fi

    if test -d $sed_prefix; then
        PATH=$sed_prefix/libexec/gnubin:$PATH
        MANPATH=$sed_prefix/libexec/gnuman:$MANPATH
        INFOPATH=$sed_prefix/share/info:$INFOPATH
    fi

    if test -d $tar_prefix; then
        PATH=$tar_prefix/libexec/gnubin:$PATH
    fi

    unset -v core_prefix sed_prefix tar_prefix
fi

# X11 apps
if test -d /usr/X11; then
    PATH=$PATH:/usr/X11/bin
    MANPATH=$MANPATH:/usr/X11/share/man
fi

if test -d /usr/X11R6; then
    PATH=$PATH:/usr/X11R6/bin
    MANPATH=$MANPATH:/usr/X11R6/share/man
fi

# Ruby gems (Homebrew)
GEM_HOME=/usr/local/opt/ruby

if test -d $GEM_HOME; then
    PATH=$GEM_HOME/bin:$PATH
    MANPATH=$GEM_HOME/share/man:$MANPATH
    export GEM_HOME
else
    unset -v GEM_HOME
fi

# Xcode
if test -x '/usr/bin/xcode-select'; then
    export XCODE=`'/usr/bin/xcode-select' --print-path`

    PATH=$PATH:$XCODE/bin
    MANPATH=$MANPATH:$XCODE/share/man
fi

# gcc tools (cygwin)
if test -d /opt/gcc-tools/bin; then
    PATH=$PATH:/opt/gcc-tools/bin
    MANPATH=$MANPATH:/opt/gcc-tools/epoch2/share/man
    INFOPATH=$INFOPATH:/opt/gcc-tools/epoch2/share/info
fi

# OpenSSL
if test -d /usr/ssl/man; then
    MANPATH=$MANPATH:/usr/ssl/man
fi

# ~/bin
if test -d $HOME/bin; then
    PATH=$HOME/bin:$PATH
fi

if test -d $HOME/share/man; then
    MANPATH=$HOME/share/man:$MANPATH
fi

if test -d $HOME/share/info; then
    INFOPATH=$HOME/share/info:$INFOPATH
fi

# add Windows' %PATH% if available (cygwin)
if [[ -n $ORIGINAL_PATH ]]; then
    PATH=$PATH:$ORIGINAL_PATH
fi

# -----------------------------------------------------------------------------
# Python
# -----------------------------------------------------------------------------

unset -v PYTHONPATH

for dir in $HOME /usr/local /usr; do
    python_dir="$dir/lib/python2.7/site-packages"

    if test -d $python_dir; then
        PYTHONPATH="$python_dir:$PYTHONPATH"
    fi

    unset -v dir python_dir
done

# -----------------------------------------------------------------------------

export PATH MANPATH INFOPATH CDPATH PYTHONPATH
