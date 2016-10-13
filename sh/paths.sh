# -----------------------------------------------------------------------------
# paths
# -----------------------------------------------------------------------------

# base paths
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:$PATH
export MANPATH=/usr/share/man:/usr/man:$MANPATH
export INFOPATH=/usr/share/info:$INFOPATH

# /usr/local
PATH=/usr/local/bin:/usr/local/sbin:$PATH
MANPATH=/usr/local/share/man:$MANPATH
INFOPATH=/usr/local/share/info:$INFOPATH

# -----------------------------------------------------------------------------
# development
# -----------------------------------------------------------------------------

# rbenv
if [ -d "$HOME/.rbenv" ] && command -v rbenv >/dev/null; then
  eval "$(rbenv init -)"
  MANPATH="$(rbenv prefix)/share/man:$MANPATH"
fi

if [ -z "$HOSTNAME" ]; then
  HOSTNAME=`hostname`
fi

# go-lang (see also bashrc.d/golang.bash)
case $HOSTNAME in
  Athena*)
    PATH=$PATH:/usr/local/opt/go/libexec/bin
    ;;
  *.atco.com)
    PATH=$PATH:/opt/go/bin
    ;;
esac

# -----------------------------------------------------------------------------
# macOS
# -----------------------------------------------------------------------------

# Homebrew (see also bashrc.d/homebrew.bash)
if [ -x /usr/local/bin/brew ]; then
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
if [ -x /usr/bin/xcode-select ]; then
  case $HOSTNAME in
    Athena*|Minerva*)
      DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
      ;;
    Erato*)
      DEVELOPER_DIR="/Library/Developer/CommandLineTools"
      ;;
    Hiroko*)
      DEVELOPER_DIR="/Developer"
      ;;
    *)
      DEVELOPER_DIR=$(xcode-select --print-path)
      ;;
  esac

  # export DEVELOPER_DIR

  darwin_ver=$(uname -r)

  if [ ${darwin_ver%%.*} -ge 15 ]; then
    PATH=$PATH:$DEVELOPER_DIR/usr/bin
    MANPATH=$MANPATH:$DEVELOPER_DIR/usr/share/man
    PATH=$PATH:$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/bin
    MANPATH=$MANPATH:$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/share/man
  else
    PATH=$DEVELOPER_DIR/usr/bin:$PATH
    MANPATH=$DEVELOPER_DIR/usr/share/man:$MANPATH
  fi

  unset -v darwin_ver
fi

# calibre
PATH=$PATH:$HOME/Applications/calibre.app/Contents/MacOS

# X11
PATH=$PATH:/opt/X11/bin
MANPATH=$MANPATH:/opt/X11/share/man

# -----------------------------------------------------------------------------
# cygwin
# -----------------------------------------------------------------------------

if [ $OSTYPE == "cygwin" ]; then
  # gcc tools
  PATH=$PATH:/opt/gcc-tools/bin
  MANPATH=$MANPATH:/opt/gcc-tools/epoch2/share/man
  INFOPATH=$INFOPATH:/opt/gcc-tools/epoch2/share/info
fi

# -----------------------------------------------------------------------------
# Linuxbrew
# -----------------------------------------------------------------------------

if [ -x $HOME/.linuxbrew/bin/brew ]; then
  PATH=$HOME/.linuxbrew/bin:$PATH
  MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
fi

# -----------------------------------------------------------------------------
# ~
# -----------------------------------------------------------------------------

PATH=$HOME/bin:$HOME/opt/bin:$HOME/opt/go/bin:$PATH
MANPATH=$HOME/share/man:$HOME/opt/share/man:$HOME/opt/man:$MANPATH
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
  local d="" p="" IFS=:

  for d in $@; do
    [ "${p#*$d}" == "$p" ] && [ -d "$d" ] && p="${p:+$p:}$d"
  done

  printf "$p"
}

PATH=$(    fixpath "$PATH")
MANPATH=$( fixpath "$MANPATH")
INFOPATH=$(fixpath "$INFOPATH")

return 0
