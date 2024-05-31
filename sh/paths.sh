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
# macOS
# -----------------------------------------------------------------------------

# Homebrew
if [ -x /usr/local/bin/brew ]; then
  # GNU coreutils (w/out `g` prefix)
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
  #INFOPATH linked to /usr/local/share/info

  # GNU findutils (w/out `g` prefix)
  PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH
  MANPATH=/usr/local/opt/findutils/share/man:$MANPATH
  INFOPATH=/usr/local/opt/findutils/share/info:$PATH

  # GNU grep (w/out `g` prefix)
  PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
  MANPATH=/usr/local/opt/grep/share/man:$MANPATH
  INFOPATH=/usr/local/opt/grep/share/info:$PATH

  # GNU sed (w/out `g` prefix)
  PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  MANPATH=/usr/local/opt/gnu-sed/share/man:$MANPATH
  #INFOPATH linked to /usr/local/share/info

  # GNU tar (w/out `g` prefix)
  PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
  MANPATH=/usr/local/opt/gnu-tar/share/man:$MANPATH
  #INFOPATH linked to /usr/local/share/info

  # llvm
  PATH=/usr/local/opt/llvm/bin:$PATH
  MANPATH=/usr/local/opt/llvm/share/man:$MANPATH

  # curl
  PATH=/usr/local/opt/curl/bin:$PATH
  MANPATH=/usr/local/opt/curl/share/man:$MANPATH

  # GNU i18n/l10n utilities
  PATH=/usr/local/opt/gettext/bin:$PATH
  MANPATH=/usr/local/opt/gettext/share/man:$MANPATH
  INFOPATH=/usr/local/opt/gettext/share/info:$INFOPATH

  # OpenSSL
  MANPATH=/usr/local/opt/openssl/share/man:$MANPATH

  # ncurses
  PATH=/usr/local/opt/ncurses/bin:$PATH
  MANPATH=/usr/local/opt/ncurses/share/man:$MANPATH

  # calendar
  PATH=/usr/local/opt/calendar/bin:$PATH
  MANPATH=/usr/local/opt/calendar/share/man:$MANPATH
  export CALENDAR_DIR=$HOME/Developer/share/calendar/src

  # m4
  PATH=/usr/local/opt/m4/bin:$PATH
fi

# Xcode
if [ -x /usr/bin/xcode-select ]; then
  # HOSTNAME is undefined in POSIX but will always(?) be present on a Mac
  # shellcheck disable=SC2039
  case $HOSTNAME in
    Citadel*)
      DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
      ;;
    Erato*)
      DEVELOPER_DIR="/Library/Developer/CommandLineTools"
      ;;
    Juno*)
      DEVELOPER_DIR="/Developer"
      ;;
    *)
      DEVELOPER_DIR=$(xcode-select --print-path)
      ;;
  esac

  darwin_ver=$(uname -r | cut -d. -f1)
  if [ "$darwin_ver" -ge 15 ]; then
    PATH=$PATH:$DEVELOPER_DIR/usr/bin
    MANPATH=$MANPATH:$DEVELOPER_DIR/usr/share/man
    PATH=$PATH:$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/bin
    MANPATH=$MANPATH:$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/share/man
  else
    PATH=$DEVELOPER_DIR/usr/bin:$PATH
    MANPATH=$DEVELOPER_DIR/usr/share/man:$MANPATH
  fi
  unset -v DEVELOPER_DIR darwin_ver
fi

# -----------------------------------------------------------------------------
# Linuxbrew
# -----------------------------------------------------------------------------

if [ "$PLATFORM" = "linux" ]; then
  for d in "$HOME" /home/linuxbrew; do
    if [ -x "$d/.linuxbrew/bin/brew" ]; then
      PATH=$d/.linuxbrew/bin:$d/.linuxbrew/sbin:$PATH
      MANPATH=$d/.linuxbrew/share/man:$MANPATH
      break
    fi
  done
  unset -v d
fi

# -----------------------------------------------------------------------------
# Visual Studio Code
# -----------------------------------------------------------------------------

if [ -d "/Applications/Visual Studio Code.app" ]; then
  PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
elif [ -d "$LOCALAPPDATA\\Programs\\Microsoft VS Code" ]; then
  PATH=$PATH:"$(cygpath -au "$LOCALAPPDATA\\Programs\\Microsoft VS Code\\bin")"
fi

# -----------------------------------------------------------------------------
# MSYS
# -----------------------------------------------------------------------------

if [ -n "$MSYSTEM_PREFIX" ]; then
  PATH=$PATH:$MSYSTEM_PREFIX/bin
fi

# ----------------------------------------------------------------------------
# npm
# ----------------------------------------------------------------------------

PATH=$XDG_DATA_HOME/npm/bin:$PATH

# -----------------------------------------------------------------------------
# ~
# -----------------------------------------------------------------------------

PATH=$HOME/bin:$HOME/opt/bin:$HOME/.local/bin:$PATH
MANPATH=$HOME/opt/share/man:$HOME/share/man:$MANPATH
INFOPATH=$HOME/opt/share/info:$INFOPATH

# -----------------------------------------------------------------------------
# rbenv
# -----------------------------------------------------------------------------

if [ -d "$RBENV_ROOT" ]; then
  if [ -d "$RBENV_ROOT/bin" ]; then
    # non-Homebrew install
    PATH=$RBENV_ROOT/bin:$PATH
  fi
  PATH=$RBENV_ROOT/shims:$PATH
  MANPATH=$RBENV_ROOT/versions/$(cat "$RBENV_ROOT/version")/share/man:$MANPATH
fi

# -----------------------------------------------------------------------------
# remove nonexistent/duplicate directories
# -----------------------------------------------------------------------------

fixpath()
( #: -- removes duplicate & nonexistent directories from colon-separated input
  #: $ PATH=$(fixpath "$PATH")

  # Enable ZSH word splitting so the IFS change below takes effect
  [ -n "$ZSH_NAME" ] && setopt SH_WORD_SPLIT

  # Set IFS to a colon so the input gets split properly.
  IFS=:

  # Check each directory: if it isn't already in the PATH, and if it exists,
  # append it to the PATH-in-progress (w/ a leading colon if necessary).
  # The unquoted `$*` is deliberate, to force word splitting at each colon.
  # shellcheck disable=SC2048
  for d in $*; do
    case ":$p:" in
      *:$d:*) false ;;
      *) [ -d "$d" ] && p="${p:+$p:}$d" ;;
    esac
  done

  # Print the new PATH.
  printf "%s" "$p"
)

PATH=$(    fixpath "$PATH")
MANPATH=$( fixpath "$MANPATH")
INFOPATH=$(fixpath "$INFOPATH")

return 0
