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
if [ -d "$HOME/.rbenv" ]; then
  # In case it isn't installed to /usr/local/bin
  PATH=$HOME/.rbenv/bin:$PATH

  if command -v rbenv >/dev/null; then
    eval "$(rbenv init -)"
    MANPATH="$(rbenv prefix)/share/man:$MANPATH"
  fi
fi

# go-lang (cygwin location)
PATH=$PATH:/opt/go/bin

# -----------------------------------------------------------------------------
# macOS
# -----------------------------------------------------------------------------

# Homebrew
if [ -x /usr/local/bin/brew ]; then
  # GNU coreutils (w/out `g` prefix)
  PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
  INFOPATH=/usr/local/opt/coreutils/share/info:$INFOPATH

  # GNU sed (installed --with-default-names)
  PATH=/usr/local/opt/gnu-sed/bin:$PATH
  MANPATH=/usr/local/opt/gnu-sed/share/man:$MANPATH
  INFOPATH=/usr/local/opt/gnu-sed/share/info:$INFOPATH

  # GNU tar (w/out `g` prefix)
  PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
  MANPATH=/usr/local/opt/gnu-tar/share/man:$MANPATH

  # OpenSSL
  MANPATH=/usr/local/opt/openssl/share/man:$MANPATH

  # ncurses
  PATH=/usr/local/opt/ncurses/bin:$PATH
  MANPATH=/usr/local/opt/ncurses/share/man:$MANPATH
fi

# -----------------------------------------------------------------------------
# Linuxbrew
# -----------------------------------------------------------------------------

if [ -x $HOME/.linuxbrew/bin/brew ]; then
  PATH=$HOME/.linuxbrew/bin:$PATH
  MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
fi

# -----------------------------------------------------------------------------
# MSYS
# -----------------------------------------------------------------------------

if [ -n $MSYSTEM_PREFIX ]; then
  PATH=$PATH:$MSYSTEM_PREFIX/bin
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
  # Set IFS to a colon so the unquoted `$*` below splits the input properly.
  local IFS=:

  # Enable ZSH word splitting so the IFS change above takes effect.
  [[ -n $ZSH_NAME ]] && setopt SH_WORD_SPLIT

  # Check each directory: if it isn't already in the PATH, and if it exists,
  # append it to the PATH-in-progress (w/ a leading colon if necessary).
  local d p; for d in $*; do
    case ":$p:" in
      *:$d:*) false ;;
      *) [ -d "$d" ] && p="${p:+$p:}$d" ;;
    esac
  done

  # Print the new PATH.
  printf "$p"
}

PATH=$(    fixpath "$PATH")
MANPATH=$( fixpath "$MANPATH")
INFOPATH=$(fixpath "$INFOPATH")

return 0
